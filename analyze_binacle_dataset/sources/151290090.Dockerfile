FROM docker-registry.delivery.realestate.com.au/shinkansen/ubuntu-ruby2.1
RUN apt-get -yq update && apt-get -yq upgrade
RUN apt-get -yq install python
RUN apt-get -yq install unzip
#RUN cd /usr/local/src && wget https://s3.amazonaws.com/ecs-preview-docs/amazon-ecs-cli-preview.tar.gz && tar zxf amazon*
ADD ecs-cli.zip /usr/local/src/ecs-cli.zip
RUN cd /usr/local/src && unzip ecs-cli.zip
RUN cd /usr/local/src/awscli-bundle && HOME=/ python ./install
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/.local/lib/aws/bin
CMD bash
