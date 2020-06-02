FROM google/cloud-sdk:latest  
  
RUN apt-get update  
RUN curl -sL https://deb.nodesource.com/setup_6.x -o node-setup.txt  
RUN chmod +x node-setup.txt  
RUN ./node-setup.txt  
RUN apt-get install -y nodejs  
RUN npm install -g gulp  
RUN echo starting gcloud setup  
RUN apt-get install python  
RUN apt-get install google-cloud-sdk-app-engine-python

