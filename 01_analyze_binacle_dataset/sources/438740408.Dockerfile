# ============================================================================================================================
# Building Environment
# ============================================================================================================================
FROM node:9.6.1 as builder

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH

COPY package.json /usr/src/app/package.json
RUN npm install 
RUN npm install react-scripts@1.1.1 -g 

COPY . /usr/src/app

ARG PUBLIC_URL
ENV PUBLIC_URL ${PUBLIC_URL}

ARG HOST_ENV
RUN node -r dotenv/config ./node_modules/.bin/react-scripts build dotenv_config_path=${HOST_ENV}.env


# ============================================================================================================================
# Runtime environment
# docker run -it --rm alpine /bin/ash
# ============================================================================================================================
FROM nginx:1.13.9-alpine

RUN rm -rf /etc/nginx/conf.d
COPY nginx.conf /etc/nginx

COPY --from=builder /usr/src/app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
