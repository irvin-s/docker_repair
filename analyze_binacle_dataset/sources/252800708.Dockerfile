  
FROM circleci/node:8-browsers  
  
RUN sudo npm install -g ember-cli@3.0.2  
RUN sudo npm install -g sass-lint  

