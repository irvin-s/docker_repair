FROM python:2.7
MAINTAINER "ffinkbeiner@inovex.de"


#copy the program files to the loader/ directory on the container
COPY newsflash-loader/main.py newsflash-loader/extract.py newsflash-loader/transform.py newsflash-loader/load.py  loader/

COPY newsflash-loader/credentials loader/credentials
COPY newsflash-loader/secret loader/secret
#TODO not that nice to create two extra layers just to copy the subfolders is there a better way?

RUN pip install --upgrade kafka-python httplib2 google-api-python-client


ENTRYPOINT [ "python", "/loader/main.py"]
