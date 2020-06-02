FROM rakudo-star  
MAINTAINER Ashley Murphy <irashp@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y build-essential vim ack-grep  
  
COPY image-files/.vim /root/.vim  
COPY image-files/.vimrc /root/  
COPY image-files/.bashrc /root/  
COPY image-files/.git-completion.sh /root/  
  
CMD /bin/bash  

