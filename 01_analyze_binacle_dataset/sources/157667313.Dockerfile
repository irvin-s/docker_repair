FROM java7jre_image

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

RUN (   apt-get update && \
        apt-get install -y wget && \
        mkdir -p /tmp/tomcat-download && \
        wget -O /tmp/tomcat-download/apache-tomcat-7.0.16.tar.gz http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.16/bin/apache-tomcat-7.0.16.tar.gz && \
        cd /tmp/tomcat-download && \
        tar xvf apache-tomcat-7.0.16.tar.gz && \
        mkdir -p /apps && \
        cd /apps && \
        mv /tmp/tomcat-download/apache-tomcat-7.0.16 . && \
        ln -sn apache-tomcat-7.0.16 tomcat7 && \
        mv /apps/tomcat7/webapps /webapps && \
        ln -sn /webapps /apps/tomcat7/webapps && \
        apt-get remove -y --auto-remove wget && \
        apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*)

EXPOSE 8080

# Define default command.
CMD ["bash"]

