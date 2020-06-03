# FROM node

# WORKDIR /app
# ENV PATH /app/node_modules/.bin:$PATH
# COPY package.json /app/package.json
# RUN npm install
# COPY ./dist /app
# RUN npm run build

FROM nginx:stable
ADD ./dist /var/www/html/
RUN rm /etc/nginx/conf.d/default.conf
ADD deploy/app.conf /etc/nginx/conf.d/app.conf
ADD deploy/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["service","nginx", "start"]
