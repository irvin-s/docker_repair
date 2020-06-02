FROM fedora:latest  
  
MAINTAINER Gerry Casey <gerard.casey@arup.com>  
  
# Libraries  
RUN dnf update -y && dnf install -y git curl npm nodejs wget  
RUN npm install -g yarn && yarn global add n && n stable  
  
# purescript and elm  
RUN yarn global add purescript elm@0.16  
  
WORKDIR /root/sierra-charlie  
  
# Expose port  
EXPOSE 4000 3000  
# Get the code  
# COPY sierra-charlie  
# WORKDIR sierra-charlie  
# RUN yarn install --no-optional  
# RUN npm run build  
# RUN npm run start-proxy&  
# RUN npm start  

