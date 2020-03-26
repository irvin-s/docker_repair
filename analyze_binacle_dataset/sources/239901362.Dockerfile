FROM pagarme/docker-nodejs:8.9

# Copy package definition files
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json

WORKDIR /app

# Install dependencies and npm dependencies
RUN apk update && \
    apk add python make g++ && \
    npm install --production

FROM pagarme/docker-nodejs:8.9

ENV APP_NAME 'superbowleto'

# Copy dependencies from the previous image
COPY --from=0 /app /app
COPY . /app
COPY script/start_server.sh /app

WORKDIR /app

EXPOSE 3000
ENTRYPOINT ["sh", "-c", "/app/start_server.sh"]
