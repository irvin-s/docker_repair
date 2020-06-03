FROM mhart/alpine-node:8.9.1 as builder  
  
WORKDIR /app  
  
COPY . /app  
  
RUN npm install  
  
RUN npm run build -- --prod  
  
FROM nginx  
  
COPY default.conf /etc/nginx/conf.d/  
  
RUN rm -rf /usr/share/nginx/html/*  
  
COPY \--from=builder /app/dist /usr/share/nginx/html  
  
CMD ["nginx", "-g", "daemon off;"]

