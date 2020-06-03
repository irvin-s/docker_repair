# Build react app
FROM node:6 as builder
RUN mkdir /whales
WORKDIR /whales
COPY whaleDemo .

RUN rm -rf .node_modules

RUN npm install --quiet
RUN npm run build

# Copy built app into nginx container
FROM nginx:1.13.5
COPY --from=builder /whales/build /usr/share/nginx/html

EXPOSE 80

