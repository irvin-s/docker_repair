FROM node:6.10.3-slim
RUN apt-get update  && apt-get install -y nginx
RUN mkdir -p /home/app
WORKDIR /home/app
COPY . /home/app
EXPOSE 8089
RUN  npm install      && npm run build 
CMD ["npm","start"]
