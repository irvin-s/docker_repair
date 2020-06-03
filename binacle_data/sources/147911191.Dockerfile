# ---- Base Node ----
FROM node:dubnium-alpine AS base
# Create a user
RUN adduser -S appuser
WORKDIR /app
COPY scripts ./scripts
EXPOSE 3000
COPY package.json .
 
#
# ---- Dependencies ----
FROM base AS dependencies
RUN npm set progress=false && npm config set depth 0
RUN npm install --production 
RUN cp -R node_modules prod_node_modules
RUN npm install
 
#
# ---- Test ----
# run linters, setup and tests
FROM dependencies AS test
COPY . .
RUN npm run lint && npm run build && npm run test-unit
 
#
# ---- Release ----
FROM base AS release
# Tell docker that all commands in this step should run as the appuser user
USER appuser
COPY --from=dependencies /app/prod_node_modules ./node_modules
COPY --from=test /app/dist ./dist
ENTRYPOINT [ "sh", "./scripts/start-service.sh" ]

#
# ---- Integration Test ----
# run integration tests
FROM dependencies AS integration
ARG integration_server_url=localhost:3000
ENV integration_server_url=${integration_server_url}
COPY . .
COPY --from=dependencies /app/prod_node_modules ./node_modules
RUN chown -R appuser /app
# Tell docker that all commands in this step should run as the appuser user
USER appuser
ENTRYPOINT [ "sh", "./scripts/run-integration.sh" ]