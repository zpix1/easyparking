FROM jjanzic/docker-python3-opencv
WORKDIR /easyparking-ml

COPY requirements.txt /easyparking-ml/

RUN python -m pip install -r /easyparking-ml/requirements.txt

COPY . /easyparking-ml/

WORKDIR /easyparking-ml/mask-rcnn/
RUN python -m pip install -r requirements.txt
RUN python setup.py install

ENTRYPOINT ["python", "/easyparking-ml/server/server.py"]
