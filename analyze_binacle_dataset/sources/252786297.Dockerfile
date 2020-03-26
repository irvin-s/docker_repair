FROM nginx:stable  
MAINTAINER The Doalitic team  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update && apt-get -y dist-upgrade && \  
apt-get -y install python-pip && rm -rf /var/lib/apt/lists/*  
RUN pip install Sphinx sphinx_rtd_theme  
  
ADD . /tmp  
WORKDIR /tmp  
  
RUN make html  
RUN mkdir -p /var/www/docs  
RUN cp -r /tmp/build/html/* /var/www/docs/  
RUN rm -rf *  
RUN chown -R www-data:www-data /var/www/docs/*  
  
CMD [ "echo", "Documentation volume: /var/www/docs" ]  

