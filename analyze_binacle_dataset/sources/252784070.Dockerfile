FROM ubuntu:xenial  
MAINTAINER bm <none@mail.invalid>  
  
ADD init.sh /tmp/  
RUN chmod +x /tmp/init.sh  
RUN bash -c "/tmp/init.sh"  
  
ENTRYPOINT "/bin/bash"  

