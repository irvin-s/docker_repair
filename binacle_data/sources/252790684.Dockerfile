FROM node:0.10  
RUN npm install -g nodemon  
  
# do not overwrite with a volume in fig.yml!  
#ADD ./package.json /saber/worker/package.json  
ADD . /saber/worker  
  
WORKDIR /saber/worker  
RUN npm install  
  
CMD ["nodemon", "/saber/worker/app/worker.js"]

