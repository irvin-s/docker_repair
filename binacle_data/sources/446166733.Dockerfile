FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y vsftpd supervisor openssh-server openssl
RUN mkdir -p /var/run/vsftpd/empty
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /var/run/sshd

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /usr/local/bin/start.sh
COPY vsftpd.conf /etc/vsftpd.conf
RUN chmod 755 /usr/local/bin/start.sh

# generate ca key & cert
RUN openssl genrsa -out /etc/ssl/private/ca.key 2048
RUN openssl req -x509 -new -key /etc/ssl/private/ca.key -days 3650 -out /etc/ssl/private/ca.pem -subj "/C=DE/ST=Berlin/L=Berlin/O=depage.net-ca/OU=IT/CN=ca.depage.net"

# generate client key & cert
RUN openssl genrsa -out /etc/ssl/private/ftp.key 2048
RUN openssl req -new -key /etc/ssl/private/ftp.key -out /etc/ssl/private/ftp.csr -subj "/C=DE/ST=Berlin/L=Berlin/O=depage.net/OU=IT/CN=localhost"

# generate signed client cert
RUN openssl x509 -req -days 365 -CA /etc/ssl/private/ca.pem -CAkey /etc/ssl/private/ca.key -CAcreateserial -CAserial serial -in /etc/ssl/private/ftp.csr -out /etc/ssl/private/ftp.pem

RUN chmod 600 /etc/ssl/private/*

COPY ssh/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
COPY ssh/ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub
RUN chmod 600 /etc/ssh/ssh_host_rsa_key

RUN useradd -m -p co.yjyxRTlonU testuser

EXPOSE 20 21 22

CMD ["/usr/bin/supervisord"]

