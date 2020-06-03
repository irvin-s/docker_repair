# Do the npm install on the full image
FROM node:8.16.0-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install --quiet --production

COPY doc/api-doc.yml doc/
COPY src src/
COPY version.json ./
COPY docker-entrypoint.sh ./

# Only copy needed pieces from the build step
FROM node:8.16.0-alpine

WORKDIR /app
COPY --from=builder /app .
RUN chmod +x ./docker-entrypoint.sh

RUN apk add --no-cache bash curl

# check every 30s to ensure this service returns HTTP 200
HEALTHCHECK CMD curl -fs http://localhost:$MIRA_API_PORT/health || exit 1

ARG MIRA_API_PORT=9100
ENV MIRA_API_PORT $MIRA_API_PORT
EXPOSE $MIRA_API_PORT

ENV MIRA_CONTAINERIZED true

# Run as non-root user for secure systems
USER 63000:63000

ENTRYPOINT ["./docker-entrypoint.sh", "node", "./src/index.js"]

