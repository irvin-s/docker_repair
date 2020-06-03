#Docker file for node, however also installs python install for bcrypt  
#this should handle npm install  
FROM iron/node:dev  
  
#install python  
RUN apk add --update \  
python \  
python-dev \  
py-pip  
  
WORKDIR /srv/app  
ADD . /srv/app  
  
ENTRYPOINT ["npm", "install"]  

