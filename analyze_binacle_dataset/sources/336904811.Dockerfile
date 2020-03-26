# Heroku uses this configuration.

# Heroku uses the package engines for its npm, Yarn, and Node versions.
# This includes Yarn 1.9.2
FROM node:10.8.0
ADD . /app
WORKDIR /app
RUN yarn
# Run the app. CMD is required to run on Heroku.
CMD npm run --silent start
