FROM nginx:1.13.5  
RUN apt-get update -y  
RUN apt-get install -y curl gnupg  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get install -y nodejs build-essential  
  
COPY ./src /app/src  
COPY ./public /app/public  
COPY package.json /app  
COPY yarn.lock /app  
  
WORKDIR /app  
  
RUN npm install -g yarn  
RUN npm install -g create-react-app  
RUN yarn  
RUN yarn build  
RUN rm -rf /usr/share/nginx/html  
RUN ln -s /app/build/ /usr/share/nginx/html  
  
COPY .docker/nginx.default.conf /etc/nginx/conf.d/default.conf  

