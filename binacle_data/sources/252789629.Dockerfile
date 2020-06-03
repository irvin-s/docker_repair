FROM centos:7  
COPY total.repo /repo.def/  
COPY nginx.conf /tmp/  
COPY prepare.sh /usr/local/bin  
COPY refresh.sh /usr/local/bin  
RUN /usr/local/bin/prepare.sh  
EXPOSE 80  
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]  
  

