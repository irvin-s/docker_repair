# Start from Node.js image
FROM node:0.10

# Install Git
RUN apt-get install -y git

# Copy source
ADD ./node_modules /opt/flak-cannon/node_modules
ADD . /opt/flak-cannon

# Set directory
WORKDIR /opt/flak-cannon

# Install deps
RUN npm install

CMD ["npm", "start"]
