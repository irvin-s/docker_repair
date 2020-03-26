FROM phusion/baseimage  
  
RUN rm -f /etc/service/sshd/down && \  
echo root:password | chpasswd  
  
COPY sshd_config /etc/ssh/  
EXPOSE 22  

