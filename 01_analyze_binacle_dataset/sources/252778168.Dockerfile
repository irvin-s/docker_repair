FROM ubuntu  
MAINTAINER Approxit <https://github.com/approxit>  
  
##########  
# System #  
##########  
RUN apt-get update -yq && \  
apt-get install -yqq --no-install-recommends \  
gcc \  
python2.7 \  
python-dev \  
python-pip \  
libssl-dev \  
&& apt-get clean \  
&& rm -r /var/lib/apt/lists/*  
  
#######  
# Env #  
#######  
ENV PROJECT_NAME prodline  
ENV PROJECT_PATH /app  
ENV PACKAGE_PATH ${PROJECT_PATH}/${PROJECT_NAME}  
  
ENV PYTHONUNBUFFERED 1  
################  
# Requirements #  
################  
COPY requirements.txt ./  
RUN pip install -r requirements.txt  
RUN rm ./requirements.txt  
  
#######  
# App #  
#######  
WORKDIR ${PROJECT_PATH}  
  
COPY run.py ./  
COPY ${PROJECT_NAME} ./${PROJECT_NAME}/  
COPY certs ./certs  
  
RUN chmod +x run.py  
ENTRYPOINT ["./run.py"]

