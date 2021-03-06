FROM node:slim AS builder

# Create app directory
WORKDIR /simulations-manager

COPY . .

RUN npm install && npm run build

###############################################################################

FROM node:slim

ENV NODE_ENV=production

WORKDIR /simulations-manager

COPY ./package* ./
RUN npm install --production && \
    npm cache clean --force

COPY --from=builder /simulations-manager/dist ./dist

COPY ./healthcheck.js ./

HEALTHCHECK --interval=13s --timeout=13s --start-period=13s \  
CMD node healthcheck.js

EXPOSE 3000

CMD [ "npm", "start" ]
