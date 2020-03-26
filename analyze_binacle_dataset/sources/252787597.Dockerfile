FROM dockerfile/nodejs  
  
MAINTAINER Ofer Brown, brownman@linnovate.net  
  
WORKDIR /home/mean  
  
# Install Mean Prerequisites  
RUN npm install -g grunt-cli bower mean-cli  
RUN bash -c 'echo -e "myApp\n" | mean init'  
RUN bash -c 'cd myApp && bower --allow-root install && npm install'  
RUN echo 'eval "$(grunt --completion=bash)"' >> ~/.bashrc  
  
ENV NODE_ENV development  
  
# Port 3000 for server  
# Port 35729 for livereload  
EXPOSE 3000 35729  

