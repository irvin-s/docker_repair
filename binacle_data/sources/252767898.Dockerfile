FROM alpine:latest  
MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"  
RUN apk add --update-cache python py-pip &&\  
pip install "awscli>=1.10,<1.11"  

