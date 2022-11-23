import os
from minio import Minio


class S3Client:
    def __init__(self, url, access_key, secret_key, data_path) -> None:
        self.client = Minio(url, access_key=access_key, secret_key=secret_key, secure=False)
        self.data_path = data_path

    def fget_image(self, bucket, image_name):
        if not self.client.bucket_exists(bucket):
            raise ValueError("Incorrect bucket")
        return self.client.fget_object(bucket, image_name, os.path.join(self.data_path, os.path.basename(image_name)))

    def get_image(self, bucket, image_name):
        if not self.client.bucket_exists(bucket):
            raise ValueError("Incorrect bucket")
        return self.client.get_object(bucket, image_name)

    def fput_image(self, bucket, image_name, img_path):
        if not os.path.exists(img_path):
            raise ValueError("Incorrect image path")
        if not self.client.bucket_exists(bucket):
            print(f"Creating bucket {bucket}")
            self.client.make_bucket(bucket)
        return self.client.fput_object(bucket, image_name, img_path)
