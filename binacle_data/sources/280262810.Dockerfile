FROM python:alpine3.6

WORKDIR /usr/src/verpy
COPY . .

RUN pip install -r requirements.txt

WORKDIR /usr/src/verpy/destination

ENTRYPOINT ["python", "../verpy.py"]
