FROM node:slim AS builder

# Create app directory
WORKDIR /web-client

COPY . .

RUN npm install && npm run build

###############################################################################

FROM node:slim

ENV NODE_ENV=production

WORKDIR /web-client

COPY --from=builder /web-client/build ./build
RUN npm install -g serve

COPY ./healthcheck.js ./

HEALTHCHECK --interval=30s --timeout=30s --start-period=30s \  
 CMD node healthcheck.js


EXPOSE 5000

CMD serve -s build















# FROM node

# # Create app directory
# WORKDIR /web-client

# # Install app dependencies
# # A wildcard is used to ensure both package.json AND package-lock.json are copied
# # where available (npm@5+)
# COPY ./build ./build 

# EXPOSE 5000

# RUN npm install
# RUN npm install -g serve


# CMD serve -s build

