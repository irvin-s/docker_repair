FROM node:latest
MAINTAINER imeoer@gmail.com
RUN apt-get update; apt-get -y install git
RUN wget -O caddy.tgz "https://caddyserver.com/download/build?os=linux&arch=amd64"
RUN mkdir caddy
RUN tar -xvzf caddy.tgz -C caddy
RUN git clone https://github.com/hyperhq/website.git
EXPOSE 8080
ENV BRANCH develop
CMD cd website && git checkout $BRANCH && git pull && /website/build.sh && /caddy/caddy -port 8080 -root /website/dist

# ./hyper pull imeoer/hyper-website:latest
# ./hyper run --size=m1 --env BRANCH="develop" -d -p 80:8080 imeoer/hyper-website:latest
