FROM ubuntu:14.04

RUN apt-get -y update \
    && apt-get -y upgrade

RUN apt-get install -y python-software-properties \
    && apt-get install -y software-properties-common \
    && apt-get -y install python-pip \
    && apt-get -y install python-dev

RUN apt-get -y install git
RUN apt-get install -y wget

# install tangelo

RUN pip install tangelo


# misc python libs

RUN pip install happybase
RUN pip install httplib2
RUN pip install tldextract
RUN pip install elasticsearch

# install mysql client

RUN wget http://dev.mysql.com/get/Downloads/Connector-Python/mysql-connector-python-1.2.3.tar.gz \
    && tar xf mysql-connector-python-1.2.3.tar.gz \
    && cd mysql-connector-python-1.2.3/ \
    && python setup.py install


# install igraph

RUN add-apt-repository -y ppa:igraph/ppa \
    && apt-get update \
    && apt-get install -y python-igraph


# install kafka python client

RUN wget https://github.com/mumrah/kafka-python/releases/download/v0.9.2/kafka-python-0.9.2.tar.gz \
    && tar -xzvf kafka-python-0.9.2.tar.gz \
    && cd kafka-python-0.9.2/ \
    && python setup.py install



# install impyla

RUN git clone https://github.com/cloudera/impyla.git \
    && cd impyla \
    && python setup.py install



# install pyodc

RUN apt-get -y install aptitude \
    && aptitude -y install g++ \
    && apt-get -y install unixodbc-dev \
    && pip install --allow-external pyodbc --allow-unverified pyodbc pyodbc


# setup tangelo conf and entry point for container

RUN adduser  --no-create-home --disabled-password --disabled-login --gecos "" tangelo
COPY tangelo.conf /etc/tangelo.conf
EXPOSE 80


# copy over the web apps and conf

COPY datawake /usr/local/share/tangelo/web/datawake
COPY domain /usr/local/share/tangelo/web/domain
COPY forensic /usr/local/share/tangelo/web/forensic
COPY forensic_v2 /usr/local/share/tangelo/web/forensic_v2
ENV PYTHONPATH /usr/local/share/tangelo/web:$PYTHONPATH



# set the default container command to run tangelo

CMD ["tangelo","-c","/etc/tangelo.conf"]
