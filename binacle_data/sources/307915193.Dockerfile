FROM node:8.5.0

# These steps ensure that yarn is only run when package.json changes
COPY package.json .
COPY yarn.lock .
RUN yarn
COPY . .
CMD ["node", "./index.js"]
