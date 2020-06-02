FROM node
RUN npm install -g parcel-bundler
RUN npm install -g typescript
RUN npm install -g cssnano
RUN mkdir -p /app
WORKDIR /app
CMD parcel --no-autoinstall src/index.html
