###############################################################################
# Stage 1.0: Image used to develop and build application
###############################################################################

FROM node:10-alpine as base

WORKDIR /opt/app

# -----------------------------------------------------------------------------
# Run preinstall scripts
# -----------------------------------------------------------------------------

COPY .dockerignore preinstal[l] preinstall/
RUN if npm run | grep -q preinstall ; then \
      npm run preinstall ; \ 
    fi

# -----------------------------------------------------------------------------
# Install dependencies
# -----------------------------------------------------------------------------

COPY package* .

RUN npm install --quiet && \
    npm cache clean --force
ENV PATH=/opt/app/node_modules/.bin:$PATH
ENV NODE_PATH=/opt/app/node_modules/:$NODE_PATH

# -----------------------------------------------------------------------------
# Run postinstall scripts
# -----------------------------------------------------------------------------

COPY .dockerignore postinstal[l] postinstall/
RUN if npm run | grep -q postinstall ; then \
      npm run postinstall ; \ 
    fi

# -----------------------------------------------------------------------------
# Copy source code to build
# -----------------------------------------------------------------------------

COPY sources .
# Make react see absolute path to src in imports
ENV NODE_PATH ./src/:$NODE_PATH 

# -----------------------------------------------------------------------------
# Stop container for exit (useful for debug)
# -----------------------------------------------------------------------------

CMD exec /bin/sh -c "trap : TERM INT; (while true; do sleep 1000; done) & wait"

###############################################################################
# Stage 1.1: Image ready to start development server
###############################################################################

FROM base as development

CMD ["npm", "start"]

###############################################################################
# Stage 1.2: Image that ready to build production bundle
###############################################################################

FROM base as builder

RUN apk add --no-cache zip

RUN npm run build

WORKDIR /opt/app/build/

CMD rm -rf /opt/app/build-prod/*; \
    zip -rq build .; \
    cp -r . /opt/app/build-prod/;

###############################################################################
# Stage 2: Image used to serve end  application through http
###############################################################################

FROM nginx:alpine

# -----------------------------------------------------------------------------
# Configure nginx
# -----------------------------------------------------------------------------

COPY nginx.conf /etc/nginx/conf.d/default.conf

# -----------------------------------------------------------------------------
# Copy static build files
# -----------------------------------------------------------------------------

COPY --from=builder /opt/app/build /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
