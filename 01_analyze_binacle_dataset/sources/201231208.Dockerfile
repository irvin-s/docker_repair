FROM oneops/centos7

WORKDIR /opt

ENV apache_archive="http://archive.apache.org/dist"
ENV t_version="7.0.67"
RUN wget -nv ${apache_archive}/tomcat/tomcat-7/v${t_version}/bin/apache-tomcat-${t_version}.tar.gz
RUN tar -xzvf apache-tomcat-${t_version}.tar.gz
RUN mv apache-tomcat-${t_version} /usr/local/tomcat7
RUN useradd -M -d /usr/local/tomcat7 tomcat7
RUN chown -R tomcat7 /usr/local/tomcat7
COPY tomcat.ini /etc/supervisord.d/tomcat.ini
COPY tomcat.sh /opt/tomcat.sh
RUN chmod +x /opt/tomcat.sh

ENV OO_HOME /home/oneops
EXPOSE 8080
