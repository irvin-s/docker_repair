FROM node:0.10
MAINTAINER Ruoshi Ling <fntsrlike@gmail.com>

# Requirment libs
RUN apt-get update && apt-get install -y libicu-dev

# Node_modules Cache
COPY ./package.json /app/package.json
COPY ./README.md /app/README.md
WORKDIR /app
RUN npm install

# Timezone (Custom)
RUN cp /usr/share/zoneinfo/Asia/Taipei /etc/localtime
RUN echo 'Asia/Taipei' > /etc/timezone

# Application
COPY . /app

# Port
EXPOSE 80

# Execute
CMD ["node", "config.js"]
