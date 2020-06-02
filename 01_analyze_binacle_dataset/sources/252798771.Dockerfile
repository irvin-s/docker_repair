FROM nginx:1.9.9  
WORKDIR /usr/src/app  
  
RUN apt-get update --fix-missing  
RUN apt-get install -y apt-utils git  
RUN apt-get install -y npm  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
COPY etc/nginx.conf /etc/nginx/nginx.conf  
COPY etc/conf.d/default.conf /etc/nginx/conf.d/default.conf  
COPY . /usr/src/app  
RUN npm install --unsafe-perm  
RUN cp -r app/* /usr/share/nginx/html  

