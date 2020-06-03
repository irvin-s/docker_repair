FROM httpd:2.2.34-alpine  
  
# Install npm  
RUN apk update && apk add --no-cache \  
nodejs=6.7.0-r1  
  
# Copy project inside image  
RUN mkdir /tmp/memento  
COPY . /tmp/memento  
  
# Build application for prod  
WORKDIR /tmp/memento  
RUN npm install  
RUN npm run prod:build  
  
# Move built application to public httpd folder  
RUN mv ./build/prod/app/* /usr/local/apache2/htdocs  
  
# Clean tmp directory  
RUN rm -rf /tmp/*  
  
# Rights for www-data  
RUN chown -R www-data /usr/local/apache2/htdocs

