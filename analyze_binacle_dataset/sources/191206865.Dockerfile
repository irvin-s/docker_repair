FROM google/nodejs
COPY . /src
EXPOSE  3000
RUN cd /src && npm install && ./node_modules/.bin/bower --allow-root install
WORKDIR /src
CMD ["npm", "start"]
