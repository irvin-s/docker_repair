# This image will be based on the oficial nodejs docker image  
FROM node:6.9  
#RUN echo 'got node'  
RUN mkdir -p /home/app/driven_admin  
  
#RUN echo 'made directory'  
# Set in what directory commands will run  
WORKDIR /home/app/driven_admin  
  
#RUN echo 'changed working dir'  
# Put all our code inside that directory that lives in the container  
ADD . /home/app/driven_admin  
  
#RUN npm install  
#RUN echo 'installing npm in client dir'  
#RUN npm install -g bower  
RUN npm install -g gulp  
  
# Tell Docker we are going to use this port  
EXPOSE 8008  
# The command to run our app when the container is run  
CMD ["gulp", "--staging"]  
  
#RUN echo 'cmd run'

