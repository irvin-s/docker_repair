FROM java7jre_image

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y python-pip zookeeper curl jq

RUN pip install awscli

ADD ./scripts /scripts

# Define default command.
CMD ["bash"]




