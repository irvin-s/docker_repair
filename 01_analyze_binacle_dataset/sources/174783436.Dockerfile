FROM centos:centos6

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum -y install wget tar unzip gcc zlib zlib-devel openssl openssl-devel unzip

RUN mkdir -p /opt/app && mkdir -p /opt/logs

ADD . /opt/
WORKDIR /opt

RUN rm -f Dockerfile build

RUN curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python
RUN pip install supervisor \
    && echo_supervisord_conf > /etc/supervisord.conf \
    && echo "[include]" >> /etc/supervisord.conf \
    && echo "files = /etc/supervisord.d/*.conf" >> /etc/supervisord.conf \
    && mkdir -p /etc/supervisord.d \
    && cp tomcat.conf scribed.conf /etc/supervisord.d/ \
    && rm -f tomcat.conf scribed.conf

ENV JAVA_HOME /opt/jdk
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin

