FROM alpine:3.4  
MAINTAINER Andrew Dunham <andrew@du.nham.ca>  
# Install needed dependencies and Radicale itself  
RUN apk add -U python curl ca-certificates && \  
cd /tmp && \  
curl -LO https://bootstrap.pypa.io/get-pip.py && \  
python /tmp/get-pip.py && \  
pip install radicale  
  
# Create user and data directories for radicale  
RUN adduser -h /home/radicale -D -s /bin/sh radicale && \  
mkdir -p /home/radicale/.config && \  
mkdir -p /data && \  
ln -s /data /home/radicale/.config/radicale && \  
chown -R radicale /data && \  
chown -R radicale /home/radicale  
  
# Set up environment  
EXPOSE 5232  
  
ENV HOME /home/radicale  
USER radicale  
WORKDIR /home/radicale  
  
CMD ["radicale"]  

