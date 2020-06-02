FROM centos:centos6

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum -y install wget tar unzip gcc zlib zlib-devel openssl openssl-devel unzip

RUN mkdir /opt/app
RUN mkdir /opt/logs
WORKDIR /opt

RUN wget http://www.reucon.com/cdn/java/jdk-6u45-linux-x64.bin -O /tmp/jdk-6u45-linux-x64.bin \
    && chmod 755 /tmp/jdk-6u45-linux-x64.bin \
    && /tmp/jdk-6u45-linux-x64.bin \
    && rm /tmp/jdk-6u45-linux-x64.bin

ENV TOMCAT_VERSION 6.0.41

RUN wget https://archive.apache.org/dist/tomcat/tomcat-6/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/catalina.tar.gz \
    && tar xzf /tmp/catalina.tar.gz -C /opt \
    && ln -s /opt/apache-tomcat-${TOMCAT_VERSION} /opt/tomcat \
    && rm /tmp/catalina.tar.gz

RUN rm -rf /opt/tomcat/webapps/*

WORKDIR /opt/tomcat/conf

RUN line1_s=$(grep -n "<Connector port=\"8080\"" server.xml|awk -F: '{print $1}') \
    && line1_e=$(cat server.xml | awk '/\/>$/ {if(NR>='$line1_s') {print NR}}'|head -1) \
    && line1=$(expr $line1_s - 1) \
    && sed -e ''$line1_s','$line1_e'd' -e ''$line1'a\    <Connector port="8080" protocol="HTTP/1.1"\n               connectionTimeout="20000"\n               redirectPort="8443" URIEncoding="utf-8" />'  server.xml > server.xml.tmp1 \
    && line2=$(grep -n "</Host>" server.xml| awk -F: '{print $1}') \
    && sed ''$line2'i\        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"\n               prefix="localhost_access_log" suffix=".txt" rotatable="false" pattern="common" resolveHosts="false"/>\n        <Context docBase="/opt/app" path="">\n        </Context>\n' server.xml.tmp1 > server.xml.tmp2 \
    && cp server.xml.tmp2 server.xml \
    && rm server.xml.tmp1 server.xml.tmp2

ADD . /opt/
WORKDIR /opt

RUN tar zxvf scribed.tar.gz \
    && chown -R root:root scribed \
    && rm -f scribed.tar.gz

RUN curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python
RUN pip install supervisor \
    && echo_supervisord_conf > /etc/supervisord.conf \
    && echo "[include]" >> /etc/supervisord.conf \
    && echo "files = /etc/supervisord.d/*.conf" >> /etc/supervisord.conf \
    && mkdir -p /etc/supervisord.d \
    && cp tomcat.conf scribed.conf /etc/supervisord.d/ \
    && rm -f tomcat.conf scribed.conf Dockerfile

ENV JAVA_HOME /opt/jdk1.6.0_45
ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin

EXPOSE 8080
