FROM ubuntu  
RUN apt-get update  
RUN apt-get install --yes curl  
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | bash -  
RUN apt-get install --yes nodejs build-essential git-core python  
RUN mkdir -p /home/coder/rooms  
RUN mkdir -p /home/coder/app  
ENV NODECODE_EXEC_PREFIX " "  
LABEL version=2  
COPY . /home/coder/app  
WORKDIR /home/coder/app  
RUN npm install  
EXPOSE 3000  
CMD node app.js  

