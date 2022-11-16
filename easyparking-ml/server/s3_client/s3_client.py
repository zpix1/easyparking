import os
from minio import Minio


class S3Client:
    def __init__(self, url, access_key, secret_key, data_path) -> None:
        self.client = Minio(url, access_key=access_key, secret_key=secret_key)
        self.data_path = data_path

    def get_image(self, bucket, image_name):
        if not self.client.bucket_exists(bucket):
            raise ValueError("Incorrect bucket")
        return self.client.fget_object(bucket, image_name, self.data_path)

    def put_image(self, bucket, image_name, img_path):
        if not os.path.exists(img_path):
            raise ValueError("Incorrect image path")
        if not self.client.bucket_exists(bucket):
            self.client.make_bucket(bucket)
        return self.client.fput_object(bucket, image_name, img_path)
