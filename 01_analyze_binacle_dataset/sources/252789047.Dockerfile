FROM python:3.6  
RUN apt-get update  
RUN apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get install -y nodejs  
RUN mkdir /code  
WORKDIR /code  
RUN mkdir requirements  
ADD requirements/base.txt /code/requirements/base.txt  
ADD requirements/testing.txt /code/requirements/testing.txt  
ADD requirements/production.txt /code/requirements/production.txt  
RUN pip install -r requirements/production.txt  
ADD ./bikeshop_project/.bowerrc .bowerrc  
ADD ./bikeshop_project/bower.json bower.json  
RUN npm cache clean  
RUN npm install --unsafe-perm -g bower  
RUN bower install --allow-root  
ADD ./bikeshop_project/package.json package.json  
ADD ./bikeshop_project/webpack.prod.config.js webpack.prod.config.js  
ADD ./bikeshop_project/webpack.base.config.js webpack.base.config.js  
RUN npm install --unsafe-perm  
ADD ./bikeshop_project/assets assets  
RUN npm run build-production  
ADD entrypoint-interface.sh /code  
ADD entrypoint-worker.sh /code  
ARG mailchimp_api_key=''  
ENV MAILCHIMP_API_KEY=$mailchimp_api_key  
ARG django_secret_key='super-secret-key'  
ENV DJANGO_SECRET_KEY=$django_secret_key  
ADD bikeshop_project /code  
EXPOSE 8000  

