FROM ubuntu:16.04

ENV SLUGIFY_USES_TEXT_UNIDECODE=yes

# install deps
RUN apt-get update -y && apt-get install -y \
        wget \
        python-dev \
        python-pip \
        libczmq-dev \
        libcurlpp-dev \
        curl \
        libssl-dev \
        git \
        inetutils-telnet \
        bind9utils \
        zip \
        unzip \
    && apt-get clean

RUN pip install --upgrade pip

# Since we install vanilla Airflow, we also want to have support for Postgres and Kubernetes
RUN pip install -U setuptools && \
    pip install kubernetes && \
    pip install cryptography && \
    pip install psycopg2-binary==2.7.4  

# install airflow
RUN pip install apache-airflow[kubernetes,postgres]

COPY bootstrap.sh /bootstrap.sh
RUN chmod +x /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]
