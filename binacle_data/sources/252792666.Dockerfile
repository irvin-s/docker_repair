FROM mono  
MAINTAINER chenxizhang "chenxizhang@qq.com"  
RUN apt-get update  
RUN apt-get install git -y  
RUN git clone https://github.com/chenxizhang/website.git  
  
EXPOSE 3579  
# WORKDIR ~/website  
# RUN chmod u+x WebSiteSample.exe  
CMD ["mono","./website/WebSiteSample.exe"]  

