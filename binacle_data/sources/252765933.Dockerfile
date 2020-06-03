#  
# ---- Base Node ----  
FROM node:alpine AS base  
# Preparing  
RUN mkdir -p /var/app && chown -R node /var/app  
# Set working directory  
WORKDIR /var/app  
# Copy project file  
COPY package.json .  
COPY yarn.lock .  
  
#  
# ---- Dependencies ----  
FROM base AS dependencies  
# install node packages  
RUN yarn install --production --no-progress  
# copy production node_modules aside  
RUN cp -R node_modules prod_node_modules  
# install ALL node_modules, including 'devDependencies'  
RUN yarn install --no-progress  
  
# Run in production mode  
ENV NODE_ENV=production  
  
#  
# ---- Test & Build ----  
# run linters, setup and tests  
FROM dependencies AS build  
COPY . .  
# Setup environment variables  
ENV HOST=0.0.0.0  
ENV PORT=4000  
ENV CLIENT_HTTP_PORT=4000  
ENV SERVER_HTTP_PORT=8080  
ENV SERVER_HOSTNAME=caesarapp.4xxi.com  
  
ENV CLIENT_HTTP_PORT=3000  
ENV CLIENT_HOSTNAME=caesarapp.4xxi.com  
  
  
ENV BASE_URL=https://caesarapp.4xxi.com  
ENV BASE_API_URL=https://caesarapp.4xxi.com  
  
RUN yarn run build --universal  
  
#  
# ---- Release ----  
FROM base AS release  
# copy production node_modules  
COPY \--from=dependencies /var/app/prod_node_modules ./node_modules  
COPY \--from=build /var/app ./  
# copy app sources  
COPY . .  
# Setup environment variables  
ENV HOST=0.0.0.0  
ENV PORT=4000  
ENV CLIENT_HTTP_PORT=4000  
# expose port and define CMD  
EXPOSE 4000  
CMD yarn run start  

