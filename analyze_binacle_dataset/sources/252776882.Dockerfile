FROM ubuntu:16.04  
MAINTAINER Conrad De Peuter <conrad.depeuter@gmail.com>  
  
RUN apt-get -yqq update  
  
# get python  
RUN apt-get -yqq install python-pip python-dev  
  
# get npm  
RUN apt-get -yqq install nodejs npm  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
ADD flask-app /flask-app  
WORKDIR /flask-app  
  
# fetch app specific deps  
RUN npm install  
RUN npm run build  
  
RUN pip install -r requirements.txt  
  
# specify the port number the container should expose  
EXPOSE 5000  
# start app  
CMD [ "python", "./app.py" ]

