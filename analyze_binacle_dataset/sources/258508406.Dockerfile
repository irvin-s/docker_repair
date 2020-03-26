FROM base_ubuntu

RUN apt-get install -y python-software-properties
RUN curl -sL https://deb.nodesource.com/setup_6.x |  bash -
RUN apt-get install -y nodejs

RUN mkdir /app

COPY . /app

WORKDIR /app

RUN npm install

CMD ["npm", "start"]
