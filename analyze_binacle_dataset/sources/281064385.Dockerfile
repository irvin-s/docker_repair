FROM node:8.11.2

WORKDIR /app

EXPOSE 9485

ADD package.json /app/
RUN npm i

# Bundle app source
ADD . /app

# Don't use npm start to ensure it runs at PID=1
CMD ["./bin/baas"]
