FROM acklenavenue/backend-sonarqube:10.0.0

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json package-lock.json ./
COPY src/config/loggly.js.sample src/config/loggly.js
COPY src/config/sequelize.js.sample src/config/sequelize.js
RUN npm install && npm install -g nodemon


# Bundle app source
COPY . .
RUN npm run build
EXPOSE 8000 9229
CMD [ "npm", "start" ]