FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install -y python3.7 python3.7-dev wget python3-pip python3.7-distutils python3-apt libgl1
RUN python3.7 -m pip install --no-cache-dir --upgrade pip setuptools
RUN ln -s python3.7 /usr/bin/python

WORKDIR /easyparking-ml

COPY requirements.txt /easyparking-ml/

RUN python -m pip install -r /easyparking-ml/requirements.txt

COPY . /easyparking-ml/

RUN wget https://github.com/matterport/Mask_RCNN/releases/download/v2.0/mask_rcnn_coco.h5

ENTRYPOINT ["python3.7", "-u", "/easyparking-ml/server/server.py"]
