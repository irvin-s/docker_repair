FROM nginx
WORKDIR /usr/share/nginx/html
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y build-essential
COPY . /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN npm install
RUN npm run build
RUN cp -r ./build/* ./
RUN rm -rf node_modules/
RUN rm -rf src/
EXPOSE 80
