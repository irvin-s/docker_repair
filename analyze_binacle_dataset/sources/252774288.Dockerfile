FROM gogs/gogs  
RUN sed -i 's/Port 22/Port 1022/' /app/gogs/docker/sshd_config  

