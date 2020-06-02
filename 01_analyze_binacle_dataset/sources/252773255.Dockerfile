FROM bhurlow/node  
RUN curl -sSL https://get.docker.com/ | sh  
ENV TERM xterm-256color  
ENV DOCKER_HOST unix:///tmp/docker.sock  
ENV DEBUG='pullup*'  
ADD . /app  
WORKDIR /app  
RUN npm install  
CMD node app.js  

