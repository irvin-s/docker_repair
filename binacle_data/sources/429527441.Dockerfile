# Start with a node 10 image with package info
FROM node:10-alpine as base
WORKDIR /app
COPY ["package*.json", "/app/"]

# From that base, install development dependancies,
# copy in the code and run the webpack build
FROM base as builder
ENV NODE_ENV development
RUN npm ci &> /dev/null
COPY [ ".", "/app/" ]
RUN NODE_ENV=production npm run build &> /dev/null

# Starting from the base again, install prodiction dependancies,
# The copy in the compiled app files from the builder and start the server
FROM base
ENV NODE_ENV production
RUN npm ci &> /dev/null
COPY ["server", "/app/server"]
COPY ["public", "/app/public"]
COPY --from=builder /app/dist /app/dist
CMD ["node", "server/index.js"]