FROM node:11-alpine
LABEL maintainer="Ocean Protocol <devops@oceanprotocol.com>"

WORKDIR /app/backend/

COPY . .

RUN npm install && \
    npm run build

ENTRYPOINT ["npm", "run", "serve"]

