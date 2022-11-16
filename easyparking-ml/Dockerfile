FROM python:3.7.15-slim-buster

WORKDIR /easyparking-ml

COPY requirements.txt /easyparking-ml/

RUN pip install -r /easyparking-ml/requirements.txt

COPY . /easyparking-ml/

WORKDIR /easyparking-ml/mask-rcnn/
RUN pip install -r requirements.txt
RUN python setup.py install

ENTRYPOINT ["python", "/easyparking-ml/server/server.py"]
