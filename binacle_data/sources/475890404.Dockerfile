# Build:
## docker build -t got-em .
# Run:
## docker run -d -p 3000:3000 --name got-em got-em

FROM node:boron

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package.json .

RUN npm install

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "npm", "start" ]