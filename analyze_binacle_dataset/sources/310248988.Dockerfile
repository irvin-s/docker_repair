FROM node:8.10.0

WORKDIR /usr/src/app

# Run install as a separate step for caching
COPY package*.json ./
RUN npm install
RUN npm install -g --no-optional @angular/cli

# Copy everything else
COPY . .

EXPOSE 4200 49153

CMD [ "npm", "start" ]