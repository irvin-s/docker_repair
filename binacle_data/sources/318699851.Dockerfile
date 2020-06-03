FROM node:lts-alpine
ADD ./dist/ssr-mat /opt/utopian
WORKDIR /opt/utopian
RUN npm install pm2 -g
EXPOSE 3000
CMD ["pm2-runtime","index.js", "-i", "max"]
