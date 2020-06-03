FROM node:6  
ENV MASTERMIND_VERSION='"0.1.0"'  
ENV MASTERMIND_API_HOST='"localhost"'  
ENV MASTERMIND_API_PORT='"3000"'  
ENV MASTERMIND_OAUTH_URI='"account.lab.fiware.org"'  
ENV MASTERMIND_OAUTH_CLIENT_ID='"f856da058c20414db0e946d234a5b9b1"'  
RUN mkdir /mastermind  
WORKDIR /mastermind  
ADD . /mastermind  
RUN npm cache clean && npm install  
  
EXPOSE 8080  
ENTRYPOINT npm run dev  

