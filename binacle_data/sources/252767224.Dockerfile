FROM node:boron-alpine  
  
MAINTAINER Alex Brazier <aejbrazier.apps@gmail.com>  
  
ENV NODE_ENV production  
ENV PORT 80  
RUN apk --update add docker && mkdir -p /app  
  
WORKDIR /app  
  
ADD package.json yarn.lock entrypoint.sh /app/  
  
RUN yarn --pure-lockfile --production  
  
COPY dist /app/  
  
EXPOSE 80  
CMD [ "sh", "entrypoint.sh"]  

