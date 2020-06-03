FROM cellofellow/ffmpeg

RUN apt-get update
RUN apt-get -y install python-pip
RUN pip install envoy
ADD convert.py /

ENTRYPOINT ["python", "/convert.py"]