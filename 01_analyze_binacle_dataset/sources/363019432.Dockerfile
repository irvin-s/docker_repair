FROM ubuntu:14.04

ENV http_proxy="http://172.28.40.9:3128/"
ENV https_proxy="http://172.28.40.9:3128/"

RUN echo 'Acquire::http::Proxy "http://172.28.40.9:3128/";' | tee -a /etc/apt/apt.conf
RUN echo 'Acquire::https::Proxy "http://172.28.40.9:3128/";'| tee -a /etc/apt/apt.conf

RUN echo "http_proxy=http://172.28.40.9:3128/" | tee -a /etc/environment
RUN echo "https_proxy=http://172.28.40.9:3128/" | tee -a /etc/environment
RUN echo "no_proxy=10.0.1.10,10.0.1.11,10.0.1.12,10.0.1.13,10.0.1.14,10.0.1.15,10.0.1.16,10.0.1.17,10.0.1.18,10.0.1.19,10.0.1.20,10.0.1.21,10.0.1.22,10.0.1.23,10.0.1.24,10.0.1.25,10.0.1.26,10.0.1.27,10.0.1.28,10.0.1.29,10.0.1.30,127.0.0.1,localhost" | tee -a /etc/environment
RUN echo "HTTP_PROXY=http://172.28.40.9:3128/" | tee -a /etc/environment
RUN echo "HTTPS_PROXY=http://172.28.40.9:3128/" | tee -a /etc/environment
RUN echo "NO_PROXY=10.0.1.10,10.0.1.11,10.0.1.12,10.0.1.13,10.0.1.14,10.0.1.15,10.0.1.16,10.0.1.17,10.0.1.18,10.0.1.19,10.0.1.20,10.0.1.21,10.0.1.22,10.0.1.23,10.0.1.24,10.0.1.25,10.0.1.26,10.0.1.27,10.0.1.28,10.0.1.29,10.0.1.30,127.0.0.1,localhost" | tee -a /etc/environment


RUN apt-get update
RUN apt-get install --force-yes -y wget
RUN chmod 777 -R /opt
RUN apt-get update
RUN wget -P /opt/ https://raw.githubusercontent.com/intracom-telecom-sdn/multinet/master/deploy/provision.sh
RUN chmod +x /opt/provision.sh
RUN /bin/bash -c "/opt/provision.sh 'http://172.28.40.9:3128/'"

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
