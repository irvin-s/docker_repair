FROM alpine-node:latest

ENV PS1="[beatrak/node-base]# "

RUN apk add --no-cache curl bind-tools iputils ca-certificates make bash ca-certificates && \
    npm i npm -g && \
    npm i nodemon \
    	  nocache \
	  forever \
	  -g