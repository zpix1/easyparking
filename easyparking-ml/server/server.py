import json
import os
import sys
import time
import traceback
import cv2
import numpy as np

from urllib3 import HTTPResponse

from image_processor import ImageProcessor
import pika
from minio import S3Error
from minio.error import MinioException
from s3_client import S3Client
import socket

MINIO_URL = os.getenv("MINIO_URL")
MINIO_PORT = int(os.getenv("MINIO_PORT"))
MINIO_IMAGES_TO_PROCESS_QUEUE = "images_to_process"
MINIO_PROCESSED_IMAGES_QUEUE = "processed_images"
IMAGES_BUCKET_NAME = "images"
IMAGES_LOCAL_PATH = "data/images"

MINIO_ACCESS_KEY = os.getenv("MINIO_SERVER_ACCESS_KEY")
MINIO_SECRET_KEY = os.getenv("MINIO_SERVER_SECRET_KEY")

RABBITMQ_URL = os.getenv("RABBITMQ_URL")
RABBITMQ_PORT = int(os.getenv("RABBITMQ_PORT"))
MINIO_URL = os.getenv("MINIO_URL")


def wait_until_reachable(url, port, max_conns=50):
    pingcounter = 0
    isreachable = False
    while isreachable is False and pingcounter < max_conns:
        print(pingcounter)
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        try:
            print(f"Attempting #{pingcounter} connection to {url}:{port}", flush=True)
            s.connect((url, port))
            isreachable = True
        except socket.error as e:
            time.sleep(0.5)
            pingcounter += 1
        s.close()
    if not isreachable:
        raise ValueError(f"Not reachable {url}:{port}")


def main():
    image_processor = ImageProcessor()

    print("Trying to ping RabbitMQ...", flush=True)
    wait_until_reachable(RABBITMQ_URL, RABBITMQ_PORT)
    print("RabbitMQ reachable!")
    print("Trying to ping Minio...", flush=True)
    wait_until_reachable(MINIO_URL, MINIO_PORT)
    print("Minio reachable!")

    s3 = S3Client(
        MINIO_URL + ":" + str(MINIO_PORT),
        MINIO_ACCESS_KEY,
        MINIO_SECRET_KEY,
        IMAGES_LOCAL_PATH,
    )

    mq_connection = pika.BlockingConnection(
        pika.ConnectionParameters(host=RABBITMQ_URL, port=RABBITMQ_PORT)
    )

    recv_channel = mq_connection.channel()
    recv_channel.queue_declare(queue=MINIO_IMAGES_TO_PROCESS_QUEUE)
    send_channel = mq_connection.channel()
    send_channel.queue_declare(queue=MINIO_PROCESSED_IMAGES_QUEUE)

    # recv_channel.basic_publish(
    #     exchange="",
    #     routing_key=MINIO_IMAGES_TO_PROCESS_QUEUE,
    #     body="""{
    #     "image_id": "123",
    #     "image_name": "img.jpg",
    #     }""",
    # )

    def on_message(ch, method, properties, body):
        try:
            print(f" [x] Received message", flush=True)
            body_json = json.loads(body)
            image_id = body_json["image_id"]
            image_name = body_json["image_name"]
            print(f"Image ID: {image_id}, Image name: {image_name}", flush=True)
            image = s3.get_image(IMAGES_BUCKET_NAME, image_name)
            image_bytes = np.fromstring(image.data, np.uint8)
            frame = cv2.imdecode(image_bytes, cv2.IMREAD_COLOR)
            masks_img, num_cars = image_processor.infer(frame, image_name)
            cars_image_name = os.path.basename(masks_img)
            s3.fput_image(IMAGES_BUCKET_NAME, cars_image_name, masks_img)
            print(f"Saved {masks_img}", flush=True)
            os.remove(masks_img)
            response = {
                "image_id": image_id,
                "processed_image_name": cars_image_name,
                "num_cars": num_cars,
            }
            response_str = json.dumps(response)
            send_channel.basic_publish(
                exchange="", routing_key=MINIO_PROCESSED_IMAGES_QUEUE, body=response_str
            )
        except KeyboardInterrupt:
            traceback.print_exc()
            print("Interrupted")
            try:
                sys.exit(0)
            except SystemExit:
                os._exit(0)
        except Exception as e:
            print(
                f"Exception while waiting for messages: {e.with_traceback()}",
                flush=True,
            )

    recv_channel.basic_consume(
        queue=MINIO_IMAGES_TO_PROCESS_QUEUE,
        on_message_callback=on_message,
        auto_ack=True,
    )
    print(" [*] Waiting for messages. To exit press CTRL+C")
    recv_channel.start_consuming()


if __name__ == "__main__":
    try:
        main()
    except S3Error as exc:
        traceback.print_exc()
        print("error occurred.")
    except MinioException as exc:
        traceback.print_exc()
        print("error occurred.")
    except KeyboardInterrupt:
        print("Interrupted")
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
    except Exception as e:
        traceback.print_exc()
