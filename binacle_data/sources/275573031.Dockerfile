FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y curl build-essential nginx libpng-dev

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN apt-get install -y nodejs

WORKDIR /app

COPY . .

RUN npm install

RUN npm run production

ADD ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]