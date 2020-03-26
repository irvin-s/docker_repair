FROM python:latest  
MAINTAINER Kyle McLamb <alloyed@tfwno.gf>  
  
RUN apt-get update  
RUN apt-get install -y zip unzip curl git  
RUN pip install hererocks  
RUN hererocks /opt/here --luarocks ^ --lua 5.1  
ENV PATH /opt/here/bin:$PATH  
  
CMD ["/bin/bash"]  

