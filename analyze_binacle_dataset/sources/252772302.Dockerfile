FROM avatao/controller:ubuntu-16.04  
  
USER root  
RUN apt-get -qy update \  
&& apt-get install -qy \  
libfontconfig \  
libjpeg-dev \  
libicu-dev \  
libxslt1-dev \  
libhyphen-dev  
  
COPY ./ /  
  
RUN chown -R user:user /opt  
  
USER user  

