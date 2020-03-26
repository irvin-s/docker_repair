FROM circleci/ruby:2.3-node  
  
# downgrade to Node v6.8.0  
RUN sudo npm cache clean -f  
RUN sudo npm install -g n  
RUN sudo n 6.8.0  
  
# install python and pip  
RUN sudo apt-get update  
RUN sudo apt-get install -y python-dev python-pip libpython-dev  
  
# install aws cli  
RUN pip install awscli --user --upgrade  
ENV PATH "$PATH:~/.local/bin"

