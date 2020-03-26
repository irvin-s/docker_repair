#  
#---- Base node ----  
FROM node:7-alpine as base  
# Create app directory  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
RUN apk add --update-cache sqlite && \  
apk add imagemagick  
  
#  
#---- Dependecies ----  
FROM base as dependencies  
ARG npm_install_args=install  
COPY ./package.json /usr/src/app  
RUN npm $npm_install_args  
  
#  
#---- Tests ----  
FROM base as tests  
COPY ./test /usr/src/app/test/  
  
#  
#---- Local storage ----  
FROM base as local_storage  
RUN mkdir /usr/src/app/local  
COPY ./local/db.schema /usr/src/app  
RUN /usr/bin/sqlite3 /usr/src/app/local/db.sqlt < /usr/src/app/db.schema  
  
#  
#---- Release ----  
FROM base as release  
ENV PORT=3035  
WORKDIR /usr/src/app  
COPY \--from=local_storage /usr/src/app/local /usr/src/app/local  
VOLUME [ "/usr/src/app/local" ]  
COPY \--from=dependencies /usr/src/app/node_modules /usr/src/app/node_modules  
COPY \--from=tests /usr/src/app/test /usr/src/app/test  
COPY ./config /usr/src/app/config  
COPY ./package.json /usr/src/app/  
COPY ./init.sh /usr/src/app  
COPY ./src /usr/src/app/src/  
EXPOSE $PORT  
CMD [ "/usr/src/app/init.sh" ]  

