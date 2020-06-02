FROM crazycode/nodejs  
  
# Install Bower & Grunt  
RUN npm install -g bower grunt-cli  
  
# Define working directory.  
WORKDIR /srv  
  
# Define default command.  
CMD ["bash"]  

