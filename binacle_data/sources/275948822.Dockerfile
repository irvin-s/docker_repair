FROM python:2.7.14

RUN pip install oci-cli
RUN apt-get update 
RUN apt-get install -y jq
