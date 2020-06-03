# Invoke with docker run -p 8000:80 <dockerimageid>
# Then use by browsing http://localhost:8000
# iTop in Docker version 2.2.0 beta
FROM ubuntu:15.04
MAINTAINER vincent.misson@hpe.com
ENV DEBIAN_FRONTEND noninterative
# Install deps for iTop
RUN apt-get update
RUN apt-get -y install apache2 unzip sed
RUN apt-get -y install mysql-server
RUN apt-get -y install php5 php5-mysql php5-ldap php5-mcrypt php5-cli
EXPOSE 80
COPY iTop-2.2.0-beta-2371.zip /tmp/iTop-2.2.0-beta-2371.zip
COPY iTop-setup.sh /tmp/iTop-setup.sh
RUN chmod 755 /tmp/iTop-setup.sh 
CMD /tmp/iTop-setup.sh

