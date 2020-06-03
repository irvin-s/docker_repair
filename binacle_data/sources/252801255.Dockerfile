FROM library/node:6.10  
RUN apt-get update -y && \  
apt-get install -y ruby  
  
RUN npm install -g grunt-cli  
RUN npm install -g grunt  
  
RUN gem update --system && gem install scss_lint  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["bash"]  

