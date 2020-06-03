FROM stackbrew/ubuntu:13.10  
MAINTAINER DerMitch <michael@dermitch.de>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
#ADD http://192.168.2.21/01proxy /etc/apt/apt.conf.d/01proxy  
# Make sure we have the latest and greatest libraries  
RUN apt-get update; apt-get upgrade -y; apt-get dist-upgrade -y;  
  
# Install base tools  
RUN apt-get install -y --no-install-recommends python git ca-certificates  
  
# Now install the server  
RUN git clone https://github.com/jrosdahl/miniircd.git /app  
  
ADD motd /app/motd  
  
EXPOSE 6667  
ENTRYPOINT ["/app/miniircd"]  
CMD ["--debug", "--verbose", "--motd", "/app/motd"]  

