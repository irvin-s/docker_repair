FROM ubuntu:14.04

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install software-properties-common curl -y

RUN apt-add-repository ppa:webupd8team/java -y
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get update
RUN apt-get install oracle-java8-installer -y

ADD ./start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 25565

ENTRYPOINT ["/start.sh"]
CMD ["2G", "1.10.2"]