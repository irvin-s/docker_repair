FROM phusion/baseimage:latest  
  
ENV DEBIAN_FRONTEND=noninteractive  
  
RUN apt-get update -qq  
RUN apt-get install -qy dante-server  
RUN apt-get clean && rm -fr /tmp/* /var/tmp/* && rm -rf /var/lib/apt/lists/*  
  
COPY danted.conf /etc/  
  
EXPOSE 1080  
CMD ["danted"]  
  

