FROM node:9.8
LABEL maintainer="Grayson Gilmore (gilmoreg@live.com)"

# Prevent npm install from running unless package.json changes
COPY ./package.json src/
RUN cd src && npm install

COPY . /src
WORKDIR src/

EXPOSE 80

CMD ["npm", "start"]
