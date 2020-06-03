FROM node:boron-slim  
  
RUN apt-get update && apt-get install -y \  
git \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /usr/src/app  
  
RUN useradd --user-group --create-home --shell /bin/false app && \  
chown app:app /usr/src/app/  
  
USER app  
ENV PATH "/usr/src/app/node_modules/.bin:$PATH"  
COPY package.json npm-shrinkwrap.json /usr/src/app/  
RUN npm install && npm cache clean  
  
EXPOSE 3000  
WORKDIR /api  
  
ENTRYPOINT [ "raml-server", "/api" ]  

