FROM gcr.io/jobtrak-155518/docker-node8-lts:latest
MAINTAINER EasyMetrics <joshuaw@easymetrics.com>

ENV APP_ENV production

# Set environment variables
RUN mkdir -p /var/www/app/current/nestjs-api-seed
ENV appDir /var/www/app/current

COPY package.json /var/www/app/current

WORKDIR ${appDir}
RUN npm i --production

# Copy production build files
# ...
COPY ./dist /var/www/app/current/nestjs-api-seed

# PM2 Configuration
# ...
COPY ./process.yml /var/www/app/current

# DotEnv Configuration
# ...
# COPY ./.env /var/www/app/current/.env

# ENV KEYMETRICS_SECRET k0qyk64ik4fnr9u
# ENV KEYMETRICS_PUBLIC akudv4ygk68kcle
# ENV INSTANCE_NAME "nestjs-api-seed"

#Expose the ports ( Nest http2/s, socket.io, keymetrics )
EXPOSE 4433 43554 80

CMD ["pm2-docker", "start", "--auto-exit", "--env", "production", "process.yml"]
