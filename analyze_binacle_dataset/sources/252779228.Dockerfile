FROM bytesized/base  
MAINTAINER maran@bytesized-hosting.com  
  
RUN apk --no-cache add python python-dev git py-pip  
RUN git clone https://github.com/drzoidberg33/plexpy.git --depth 2 /app/plexpy  
  
EXPOSE 8181  
COPY static/ /  
  
VOLUME /data /config  

