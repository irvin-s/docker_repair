FROM python  
MAINTAINER Cheuk Wing leung "cwleung@kth.se"  
RUN pip install grip  
RUN mkdir /mnt/workspace  
  
WORKDIR /mnt/workspace  
ENTRYPOINT ["grip", "0.0.0.0:80"]  

