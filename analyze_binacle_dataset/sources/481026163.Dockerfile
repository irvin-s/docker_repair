FROM ubuntuffmpegnode3

# ENV cachebust = 148988344445

# Create app directory

RUN mkdir -p /usr/src/app/compression_server
WORKDIR /usr/src/app/compression_server

# Install app dependencies
# COPY . /usr/src/app/
COPY ./package.json /usr/src/app/compression_server/package.json


RUN npm install

EXPOSE 4000

# CMD ["npm", "run", "gulp"]

CMD ["node", "/bin/www"]