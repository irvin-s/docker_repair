FROM debian:jessie  
  
ENV DEBIAN_FRONTEND noninteractive  
  
## Base packages  
RUN apt-get update -q && apt-get upgrade -y -q &&\  
apt-get install -y python2.7 python-pip python-dev libffi-dev  
  
## Radicale installation  
RUN pip install --upgrade radicale passlib cffi bcrypt  
  
# Adds a custom non root user with home directory  
RUN useradd -d /home/radicale -m radicale  
  
# Create data and config folders  
RUN mkdir -p /data/radicale /home/radicale/.config  
RUN ln -s /data/radicale /home/radicale/.config/radicale  
RUN chown -R radicale /data/radicale/ /home/radicale/.config  
  
EXPOSE 5232  
VOLUME ["/data/radicale"]  
  
# Fix empty $HOME  
ENV HOME /home/radicale  
USER radicale  
WORKDIR /home/radicale  
  
ENTRYPOINT ["radicale"]  

