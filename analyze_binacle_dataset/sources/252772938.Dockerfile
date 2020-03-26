FROM mhart/alpine-node:latest  
USER root  
  
MAINTAINER Kevin Richter<me@kevinrichter.nl>  
  
WORKDIR /app  
  
COPY . .  
  
RUN apk add --no-cache make gcc g++ python  
RUN npm install --no-package-lock  
RUN npm run build  
  
ENV MONGO_HOST ""  
ENV SEARCH_SCHEDULE "0 */15 * * * *"  
ENV TZ "Europe/Amsterdam"  
ENV AVISTAZ_USERNAME ""  
ENV AVISTAZ_PASSWORD ""  
ENV NODE_ENV "production"  
EXPOSE 3000  
CMD ["npm", "start"]  

