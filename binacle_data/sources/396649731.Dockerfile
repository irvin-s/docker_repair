FROM node:0.10

# Install Git
RUN apt-get install -y git

# Add source
ADD ./node_modules /opt/clay-mobile/node_modules
ADD . /opt/clay-mobile

WORKDIR /opt/clay-mobile

# Install app deps
RUN npm install

CMD ["npm", "start"]
