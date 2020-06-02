FROM ubuntu:latest
MAINTAINER Matt Erasmus <code@zonbi.org>
RUN groupadd vsaq
RUN useradd -r -g vsaq -d /opt/vsaq -s /usr/bin/nologin -c "VSAQ User" vsaq
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -qy git ant openjdk-7-jdk unzip curl
RUN git clone https://github.com/google/vsaq.git /opt/vsaq
RUN chown -R vsaq:vsaq /opt/vsaq
RUN curl https://s3-eu-west-1.amazonaws.com/vsaq/runme.sh > /opt/vsaq/runme.sh
RUN chmod 750 /opt/vsaq/runme.sh
RUN chown vsaq:vsaq /opt/vsaq/runme.sh
WORKDIR /opt/vsaq
RUN ./do.sh install_deps
RUN ./do.sh build
RUN chgrp -R vsaq build
RUN chmod g+w build
RUN sed -i 's/127\.0\.0\.1/0\.0\.0\.0/' /opt/vsaq/vsaq_server.py
EXPOSE 9000
USER vsaq
CMD ["/opt/vsaq/runme.sh"]
