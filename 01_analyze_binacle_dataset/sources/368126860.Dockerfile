######################################################################################
#                                                                                    #
# To build: docker build -t ubuntu:scribengin directory                              # 
# To run:   docker run -t -i ubuntu:scribengin  /bin/bash                            #
#                                                                                    #
######################################################################################
FROM ubuntu:latest
#FROM ubuntu:latest
MAINTAINER Tuan Nguyen <tuan@demandcube.com>

#Update and installl the dependencies
RUN echo "Update and install the requirement software"
RUN apt-get update 
RUN apt-get install -y wget openssh-server openssh-client rsync vim bc

RUN apt-get install -y openjdk-7-jdk
RUN echo 'JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"' >> /etc/environment

#Configure root Account
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd

RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

#ADD authorized_keys /opt/authorized_keys
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
ADD tmp/authorized_keys /root/.ssh/authorized_keys
RUN chmod 644 /root/.ssh/authorized_keys

#Configure neverwinterdp account
RUN echo "Create neverwinterdp user account and setup home directory"

#ENV HOME /home/neverwinterdp
#RUN useradd -m -d /home/neverwinterdp -s /bin/bash -c "neverwinterdp user" -p $(openssl passwd -1 neverwinterdp)  neverwinterdp
#RUN echo "neverwinterdp ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#A bug with file creation permission, need to create a template ssh configuration and copy to the account in the post installation

#EXPOSE Ports
EXPOSE 22 2181 9092 50070 8088 9000

CMD ["/usr/sbin/sshd", "-D"]

#Download java opensource projects
#RUN wget -q -O - http://mirrors.digipower.vn/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt
RUN wget -q -O - http://jenkinsdp.do.demandcube.com/zookeeper-3.4.6.tar.gz | tar -xzf - -C /opt
RUN mv /opt/zookeeper-3.4.6 /opt/zookeeper
RUN cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg

#RUN wget -q http://apache.01link.hk/kafka/0.8.2.0/kafka_2.10-0.8.2.0.tgz -O /tmp/kafka_2.10-0.8.2.0.tgz
RUN wget -q http://jenkinsdp.do.demandcube.com/kafka_2.10-0.8.2.0.tgz -O /tmp/kafka_2.10-0.8.2.0.tgz
RUN tar xfz /tmp/kafka_2.10-0.8.2.0.tgz -C /opt
RUN mv /opt/kafka_2.10-0.8.2.0 /opt/kafka

#RUN wget -q  https://archive.apache.org/dist/hadoop/core/hadoop-2.4.0/hadoop-2.4.0.tar.gz -O /tmp/hadoop-2.4.0.tar.gz
RUN wget -q  http://jenkinsdp.do.demandcube.com/hadoop-2.4.0.tar.gz -O /tmp/hadoop-2.4.0.tar.gz
RUN tar xfz /tmp/hadoop-2.4.0.tar.gz -C /opt
RUN mv /opt/hadoop-2.4.0 /opt/hadoop



#Run Post installation
ADD bootstrap/post-install /tmp/post-install
RUN chmod +x /tmp/post-install/post-install.sh

RUN mkdir -p        /tmp/post-install/ssh-config
ADD tmp/id_rsa*     /tmp/post-install/ssh-config/
RUN cat             /tmp/post-install/ssh-config/id_rsa.pub > /tmp/post-install/ssh-config/authorized_keys
RUN chmod -R 700    /tmp/post-install/ssh-config && chmod 644 /tmp/post-install/ssh-config/authorized_keys

#Move Scribengin release
RUN mkdir -p  /opt/scribengin/
ADD tmp/release /tmp/post-install/release/


RUN /tmp/post-install/post-install.sh

#Set up ssh for neverwinterdp user
#RUN su neverwinterdp -c "sudo cat        /tmp/post-install/ssh-config/id_rsa.pub > /home/neverwinterdp/.ssh/authorized_keys"
#RUN su neverwinterdp -c "chmod -R 700    /home/neverwinterdp/.ssh/ && chmod 644 /home/neverwinterdp/.ssh/authorized_keys"


RUN rm -rf          /tmp/*.tgz
RUN rm -rf          /tmp/post-install
