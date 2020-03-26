FROM node:10

ARG COMMIT_REF
ARG BUILD_DATE

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

# At this point we just have the package.json files
RUN npm install

# Bundle app source
COPY . .

# Run any other build steps such as `npm run build`

ENV APP_COMMIT_REF=${COMMIT_REF} \
    APP_BUILD_DATE=${BUILD_DATE}

EXPOSE 3000

CMD [ "npm", "start" ]