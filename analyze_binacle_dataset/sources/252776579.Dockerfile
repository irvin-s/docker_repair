FROM node:8.2.1-alpine  
  
# Create tmp directory  
RUN mkdir -p /tempdir  
  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json /usr/src/app/  
RUN npm install  
  
# Bundle app source  
COPY . /usr/src/app  
  
# Define environment variable  
ENV AWS_ACCESS_KEY_ID {put_AWS_ACCESS_KEY_ID_here}  
ENV AWS_SECRET_ACCESS_KEY {PUT_AWS_SECRET_ACCESS_KEY_HERE}  
ENV AWS_REGION {PUT_AWS_REGION_HERE}  
ENV AWS_BUCKET_NAME {PUT_AWS_BUCKET_NAME_HERE}  
ENV AZURE_CLIENT_ID {PUT_AZURE_CLIENT_ID_HERE}  
ENV AZURE_DOMAIN {PUT_AZURE_DOMAIN_HERE}  
ENV AZURE_SECRET {PUT_AZURE_SECRET_HERE}  
ENV AZURE_ADL_ACCOUNT_NAME {PUT_AZURE_ADL_ACCOUNT_NAME_HERE}  
ENV TEMP_FOLDER {PUT_TEMP_FOLDER_HERE}  
ENV USE_REDIS {OPTIONAL_VARIABLE_TRUE/FALSE}  
#ENV REDIS_PORT {OPTIONAL_VARIABLE_DEFAULT_6379}  
#ENV REDIS_HOST {OPTIONAL_VARIABLE_DEFAULT_REDIS}  
CMD [ "node", "./lib/src/index.js" ]

