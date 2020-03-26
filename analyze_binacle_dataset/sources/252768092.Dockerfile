FROM nginx  
  
COPY sshd_config /etc/ssh/  
COPY nginx.conf /etc/nginx/  
  
COPY init_container.sh /bin  
RUN chmod 700 /bin/init_container.sh  
  
# SSH Server support for Tux  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends openssh-server \  
&& echo "root:Docker!" | chpasswd  
  
CMD /bin/init_container.sh && nginx -g 'daemon off;'  
  
EXPOSE 80 2222  

