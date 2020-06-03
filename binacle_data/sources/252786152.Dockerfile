FROM node:6.5.0  
RUN npm install -g clean-css  
ENTRYPOINT ["/bin/bash","-c"]  

