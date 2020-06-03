FROM node:alpine AS build-react
WORKDIR /src
ADD ./ui/package.json /src/ui/package.json
RUN cd /src/ui && npm install
COPY ./ui ./ui
RUN cd /src/ui && npm run-script build

FROM nginx:alpine  
COPY --from=build-react /src/ui/build /usr/share/nginx/html
