FROM node:lts-alpine
ADD . /opt/utopian
WORKDIR /opt/utopian
RUN npm install pm2 -g
EXPOSE 5000
CMD ["pm2-runtime", "index.js", "-i", "max"]