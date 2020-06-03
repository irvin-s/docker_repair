FROM node:10-alpine as builder
ENV NODE_ENV production
RUN apk --no-cache add build-base python
RUN npm install npm@6 --global --quiet
RUN mkdir -p /opt/target/packages
WORKDIR /opt/src
COPY . .
RUN npm ci
ARG SCOPE
RUN npx lerna exec --scope $SCOPE -- 'ln -s ./packages/$(basename $PWD) /opt/target/main'
RUN npx lerna exec --scope $SCOPE --include-filtered-dependencies -- 'mv $PWD /opt/target/packages/'
RUN npx npm-package-filter --only $SCOPE --type=package --output /opt/target/package.json
RUN npx npm-package-filter --only $SCOPE --type=package-lock --output /opt/target/package-lock.json

FROM node:10-alpine
EXPOSE 5000
ENV NODE_ENV production
RUN apk --no-cache add build-base python
RUN npm install npm@6 --global --quiet
WORKDIR /usr/src/app
COPY --from=builder /opt/target .
RUN npm ci
CMD ["npm", "--prefix", "main", "start"]
