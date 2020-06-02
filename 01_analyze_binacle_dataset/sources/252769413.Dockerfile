FROM ubuntu:16.04  
RUN apt-get update  
RUN apt-get install -y vim curl unzip sudo markdown  
RUN apt-get install -y git apache2 apache2-dev  
RUN apt-get install -y autoconf2.13 python  
RUN apt-get install -y g++ libz-dev  
  
ADD *.sh /  
RUN chmod +x *.sh  
  
RUN /get-v8.sh /  
#RUN /make-v8.sh /  
#RUN mkdir -p /repo/v8/out/x64.release/lib.target  
#ADD libv8-static-x64.release.tar /repo/v8/out/x64.release/lib.target  
RUN mkdir -p /repo/v8/out/  
  
CMD [ "vmstat", "5" ]  

