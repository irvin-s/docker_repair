FROM ubuntu:14.04

ENV http_proxy=

RUN apt-get update
RUN apt-get install --force-yes -y wget
RUN chmod 777 -R /opt
RUN apt-get update
RUN wget -P /opt/ https://raw.githubusercontent.com/intracom-telecom-sdn/multinet/master/deploy/provision.sh
RUN chmod +x /opt/provision.sh
RUN /bin/bash -c "/opt/provision.sh $http_proxy"

# Configure ssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root123' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN mkdir -p /root/.ssh
RUN touch /root/.ssh/known_hosts
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
