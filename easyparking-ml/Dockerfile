FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install -y python3.7 python3.7-dev wget build-essential curl
RUN apt install -y python3-pip
RUN apt install -y python3.7-distutils
RUN apt install -y python3-apt
RUN python3.7 -m pip install --no-cache-dir --upgrade pip setuptools
RUN ln -s python3.7 /usr/bin/python
RUN apt install -y ffmpeg libsm6 libxext6

WORKDIR /easyparking-ml

COPY requirements.txt /easyparking-ml/

RUN python -m pip install -r /easyparking-ml/requirements.txt

COPY . /easyparking-ml/

ENTRYPOINT ["python3.7", "/easyparking-ml/server/server.py"]
