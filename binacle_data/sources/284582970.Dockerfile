FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install -y --fix-missing build-essential 
RUN apt-get install -y --fix-missing gcc 
RUN apt-get install -y --fix-missing python-dev 
RUN apt-get install -y --fix-missing python-pip 
RUN apt-get install -y --fix-missing libmysqlclient-dev 
RUN apt-get install -y --fix-missing git  
RUN apt-get install -y --fix-missing wget 
RUN apt-get install -y --fix-missing unzip 
RUN apt-get install -y --fix-missing firefox
RUN apt-get install -y --fix-missing xvfb 
RUN apt-get install -y --fix-missing tar

RUN apt-get update -y
RUN apt-get install -y --fix-missing curl
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz
RUN mkdir -p /usr/local/gcloud
RUN tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz
RUN /usr/local/gcloud/google-cloud-sdk/install.sh
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

WORKDIR /app

ENV PATH="/app:${PATH}"

COPY unsubscribe/geckodriver.sh /app/geckodriver.sh
RUN sh /app/geckodriver.sh

RUN pip install setuptools -U
COPY unsubscribe/requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt
RUN pip install --ignore-installed urllib3



COPY unsubscribe/source/ /app/
COPY auth /auth/

ENV PYTHONPATH /app/

RUN echo "$(cat /app/main.py)\nmainSlave()" > /app/main.py

ENTRYPOINT ["python"]

CMD ["main.py"]

# cp unsubscribe/Dockerfile* .; docker build -f Dockerfile_slave -t latest .; docker tag latest gcr.io/consulting-2718/unsubslave; docker push gcr.io/consulting-2718/unsubslave;
