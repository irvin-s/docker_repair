FROM akshmakov/linuxgsm:base  
  
LABEL maintainer="akshmakov@gmail.com"  
  
RUN linuxgsm q3server && \  
yes Y | q3server install  
  
CMD q3server start  

