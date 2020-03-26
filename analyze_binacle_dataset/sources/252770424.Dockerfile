FROM golang:alpine  
MAINTAINER Nathan Osman <nathan@quickmediasolutions.com>  
  
# Git is required  
RUN \  
apk add --no-cache git && \  
rm -rf /var/lib/apt/lists/*  
  
# Build the application  
RUN go get github.com/AskUbuntu/tbot  
  
# Copy the files needed during runtime  
COPY www/ /root/www/  
  
# Default values for settings  
ENV \  
ADDR=0.0.0.0:8000 \  
ROOT_PATH=/root/www \  
DATA_PATH=/root/data \  
ADMIN_PASSWORD=password  
  
# Default command for launching the application  
CMD tbot  
  
# Expose the default port  
EXPOSE 8000  

