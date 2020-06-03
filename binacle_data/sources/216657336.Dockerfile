FROM node:4.4

WORKDIR /home/ymple

COPY api/ api/
COPY app.js app.js
COPY assets/ assets/
COPY config/ config/
COPY package.json package.json
COPY views/ views/
COPY Gruntfile.js Gruntfile.js
COPY .sailsrc .sailsrc
#Temporary solution
#--------temporary
COPY node_modules/ node_modules/
COPY .tmp/ .tmp/
#---------------
ENV NODE_ENV 'development'
RUN npm -g install sails
RUN npm -g install grunt-cli

RUN npm install

CMD ["node","app.js"]
