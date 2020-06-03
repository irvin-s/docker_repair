FROM binocarlos/nodejs  
MAINTAINER Kai Davenport <kaiyadavenport@gmail.com>  
  
ADD . /srv/app  
RUN cd /srv/app && npm install  
  
WORKDIR /srv/app  
ENTRYPOINT ["node", "cli.js"]  
CMD [""]

