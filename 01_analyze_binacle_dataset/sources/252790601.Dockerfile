FROM alpine:3.4  
# File Author / Maintainer  
LABEL authors="Carlos Yagüe Méndez <carlos.yague@upf.edu>"  
  
# Update & install required packages  
RUN apk add --update nodejs bash git  
  
RUN mkdir database  
  
# Install app dependencies  
COPY package.json /www/package.json  
RUN cd /www; npm install  
RUN mkdir volume  
RUN mkdir ssl_certificate  
  
# Copy app source  
COPY . /www  
  
# Set work directory to /www  
WORKDIR /www  
  
# set your port  
ENV PORT 4000  
# expose the port to outside world  
EXPOSE 4000  
# start command as per package.json  
CMD ["npm", "start"]  

