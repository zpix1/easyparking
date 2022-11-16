import os
import sys
import time

# from image_processor import ImageProcessor
import pika
from minio import S3Error
from s3_client import *
import socket

MINIO_URL = os.getenv("MINIO_URL")
MINIO_PORT = int(os.getenv("MINIO_PORT"))
MINIO_IMAGES_TO_PROCESS_QUEUE = "images_to_process"
MINIO_PROCESSED_IMAGES_QUEUE = "processed_images"

MINIO_ACCESS_KEY = os.getenv("MINIO_SERVER_ACCESS_KEY")
MINIO_SECRET_KEY = os.getenv("MINIO_SERVER_SECRET_KEY")

RABBITMQ_URL = os.getenv("RABBITMQ_URL")
RABBITMQ_PORT = int(os.getenv("RABBITMQ_PORT"))

IMAGES_BUCKET_NAME = "images"
IMAGES_LOCAL_PATH = "./data/images"

def wait_until_reachable(url, port, max_conns=50):
    pingcounter = 0
    isreachable = False

    while isreachable is False and pingcounter < max_conns:
        print(pingcounter)

        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        try:
            s.connect((url, port))
            isreachable = True
        except socket.error as e:
            time.sleep(0.5)
            pingcounter += 1
        s.close()

    if not isreachable:
        raise ValueError(f"Not reachable {url}:{port}")

def main():

    # image_processor = ImageProcessor()

    print("Trying to ping rabbitmq...", flush=True)
    wait_until_reachable(RABBITMQ_URL, RABBITMQ_PORT)
    print("RabbitMQ reachable!")
    print("Trying to ping Minio...", flush=True)
    wait_until_reachable(MINIO_URL, MINIO_PORT)
    print("Minio reachable!")

    s3 = s3_client.S3Client(
        MINIO_URL, MINIO_ACCESS_KEY, MINIO_SECRET_KEY, IMAGES_LOCAL_PATH)

    mq_connection = pika.BlockingConnection(
        pika.ConnectionParameters(host=RABBITMQ_URL))

    channel = mq_connection.channel()
    channel.queue_declare(queue=MINIO_IMAGES_TO_PROCESS_QUEUE)

    channel.basic_publish(exchange='', routing_key=MINIO_IMAGES_TO_PROCESS_QUEUE, body="""{
        "image_id": "123",
        "image_url": "img.jpg",
        }"""
                          )

    def callback(ch, method, properties, body):
        # print(s3.get_image(IMAGES_BUCKET_NAME, "img.jpg"))
        print(f" [x] Received {body}", flush=True)
        # image_processor.infer("")


    channel.basic_consume(queue=MINIO_IMAGES_TO_PROCESS_QUEUE,
                          on_message_callback=callback, auto_ack=True)
    print(' [*] Waiting for messages. To exit press CTRL+C')
    channel.start_consuming()


if __name__ == "__main__":
    try:
        main()
    except S3Error as exc:
        print("error occurred.", exc)
    except KeyboardInterrupt:
        print('Interrupted')
        try:
            sys.exit(0)
        except SystemExit:
            os._exit(0)
