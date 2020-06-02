FROM harishanand95/videoserver
MAINTAINER Harish Anand "https://github.com/harishanand95"
ARG CACHEBUST=1
RUN echo "TrustedUserCAKeys /etc/ssh/ca-user-certificate-key.pub" >> /etc/ssh/sshd_config
EXPOSE 22
EXPOSE 8080
EXPOSE 8088
EXPOSE 1935
COPY config/certificate_authority/keys/ca-user-certificate-key.pub /etc/ssh/ca-user-certificate-key.pub
RUN sed -i '$ a LANG="en_US.UTF-8"' /etc/profile
CMD    ["/usr/sbin/sshd", "-D"]