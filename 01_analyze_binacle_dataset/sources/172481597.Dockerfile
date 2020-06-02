FROM node
WORKDIR /app

# Nodemon
RUN npm install -g nodemon

# Build modules
ADD package.json /app/
RUN npm install && npm cache clean

# Copy Code
ADD . /app/

CMD ["npm", "start"]
