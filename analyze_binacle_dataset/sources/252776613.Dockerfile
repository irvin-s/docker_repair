FROM node:6-slim  
MAINTAINER Alberto Contreras <a.contreras@catchdigital.com>  
  
# Set directory path  
ENV DIRPATH /usr/app  
  
# Install angular cli  
RUN npm install -g @angular/cli  
  
# Set port to 3000  
EXPOSE 3000  
# Set bin folder on PATH  
WORKDIR $DIRPATH  
RUN echo "export PATH=$DIRPATH/node_modules/.bin:$PATH" >> /home/node/.bashrc  
  
# Set serve  
CMD ng serve --host 0.0.0.0 --port 3000  

