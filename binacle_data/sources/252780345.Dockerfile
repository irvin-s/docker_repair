FROM conyac/base:ubuntu20171201  
  
ENV SELENIUM_VERSION=3.9.1 \  
GECKODRIVER_VERSION=0.19.1  
COPY ./scripts /opt/  
RUN /opt/build.sh  
  
EXPOSE 4444 5555 5900  
CMD exec /opt/start.sh  

