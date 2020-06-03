FROM node:7

RUN apt-get update && apt-get -y install libpng12-0 git

WORKDIR /brewpi-ui 
COPY . .
RUN chmod +x post-install.sh
RUN npm install --loglevel=warn --unsafe-perm
RUN npm run build --loglevel=warn --unsafe-perm 

EXPOSE 3000
CMD ["npm", "run", "start:prod"]
