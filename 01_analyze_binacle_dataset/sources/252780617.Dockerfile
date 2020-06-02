FROM node:6-slim  
MAINTAINER Sean L. Mooney <bable4@gmail.com>  
  
RUN groupadd -r slidedeck && useradd -r -g slidedeck slidedeck && \  
mkdir -p /slidedeck mkdir -p /slidedeck/slides  
  
WORKDIR /slidedeck  
  
#COPY index.html /slidedeck/slides/  
RUN apt-get update  
RUN apt-get install -y curl git bzip2  
  
# Install reveal.js  
RUN git clone https://github.com/hakimel/reveal.js.git  
  
RUN cd reveal.js; npm install  
RUN npm install -g grunt  
  
EXPOSE 8000  
RUN chown -R slidedeck:slidedeck /slidedeck  
  
WORKDIR /slidedeck/reveal.js  
  
CMD ["npm", "start"]  
  

