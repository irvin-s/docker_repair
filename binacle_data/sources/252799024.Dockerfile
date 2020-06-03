FROM ubuntu:15.10  
MAINTAINER niquola  
  
RUN apt-get update && apt-get install -y openssh-server python-apt  
RUN apt-get install -y openjdk-8-jdk  
RUN apt-get install -y nodejs  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
RUN locale-gen en_US.UTF-8  
RUN update-locale LANG=en_US.UTF-8  
RUN apt-get install -y postgresql  
RUN apt-get -y install sudo  
RUN apt-get -y install python-psycopg2 libpq-dev  
RUN apt-get -y install npm  
  
RUN mkdir /root/.ssh  
ADD secure/id_rsa.pub /root/.ssh/  
RUN cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys  
  
RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd  
  
EXPOSE 22  
CMD ["/usr/sbin/sshd", "-D"]  

