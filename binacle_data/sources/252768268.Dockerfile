# INSTALL CENTOS  
FROM centos:centos7  
  
#INSTALL LIBAIO1 & UNZIP (NEEDED FOR STRONG-ORACLE)  
RUN yum -y update \  
&& yum install -y curl \  
&& yum install -y libaio \  
&& yum install -y unzip \  
&& yum install -y gcc gcc-c++ make \  
&& curl --silent --location https://rpm.nodesource.com/setup_6.x | bash - \  
&& yum -y install nodejs \  
&& yum install -y git \  
&& npm install -g strongloop  
  
#ADD ORACLE INSTANT CLIENT  
ADD . /tmp/  
RUN yum -y localinstall /tmp/oracle* --nogpgcheck  
RUN mkdir /usr/lib/oracle/12.2/client/network/admin -p  
  
ENV ORACLE_HOME=/usr/lib/oracle/12.2/client64  
ENV PATH=$PATH:$ORACLE_HOME/bin  
ENV LD_LIBRARY_PATH=$ORACLE_HOME/lib  
ENV TNS_ADMIN=$ORACLE_HOME/network/admin  
  
COPY ./myapp /opt/myapp  
RUN cd /opt/myapp  
  
RUN npm install loopback-connector-oracle --save \  
&& npm install oracledb  
  
EXPOSE 8080  
CMD [ "node", "/opt/myapp/." ]

