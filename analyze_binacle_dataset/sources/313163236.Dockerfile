#
# STAGE 1
# - Install and build necessary dependencies
#
FROM node:10-alpine as build
RUN apk upgrade --no-cache && apk add --no-cache python build-base openjdk8 nss
COPY admin/public /app/admin/public
COPY admin/src /app/admin/src
COPY admin/.browserslistrc /app/admin/.browserslistrc
COPY admin/babel.config.js /app/admin/babel.config.js
COPY admin/package.json /app/admin/package.json
COPY admin/package-lock.json /app/admin/package-lock.json
COPY admin/postcss.config.js /app/admin/postcss.config.js
COPY admin/tsconfig.json /app/admin/tsconfig.json
COPY admin/tslint.json /app/admin/tslint.json
COPY admin/vue.config.js /app/admin/vue.config.js
COPY gradle /app/gradle
COPY public /app/public
COPY src /app/src
COPY tests /app/tests
COPY build.gradle.kts /app/build.gradle.kts
COPY env.test /app/env.test
COPY gradlew /app/gradlew
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
COPY settings.gradle /app/settings.gradle
WORKDIR /app
RUN npm ci && npm ci --prefix admin && npm cache clean --force
RUN npm run build
RUN mkdir data && npm test
RUN npm prune --production

#
# STAGE 2
# - Keep Only runtime libraries: no build tool is allowed in production.
#
FROM node:10-alpine
LABEL maintainer="Jan-Lukas Else (https://jlelse.dev)"

ENV NODE_ENV=production

# Copy just needed directories
COPY --from=build /app/admin/dist /app/admin/dist
COPY --from=build /app/app /app/app
COPY --from=build /app/public /app/public
COPY --from=build /app/package.json /app/package.json
COPY --from=build /app/package-lock.json /app/package-lock.json
COPY --from=build /app/node_modules /app/node_modules

WORKDIR /app
RUN mkdir data
VOLUME ["/app/data"]

EXPOSE 8080
CMD ["npm", "start"]
