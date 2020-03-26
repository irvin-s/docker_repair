# Build stage [go]  
FROM golang:alpine AS go-build  
COPY . $GOPATH/src/github.com/AUT-CEIT/Registerator  
RUN apk update && apk add git  
WORKDIR $GOPATH/src/github.com/AUT-CEIT/Registerator  
RUN go get -v && go build -v -o /Registerator  
  
# Build stage [react]  
FROM node:alpine as node-build  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
COPY ./ui/package.json /usr/src/app/  
RUN npm install  
COPY ./ui /usr/src/app  
RUN npm run build  
  
# Final stage  
FROM alpine  
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*  
EXPOSE 8080/tcp  
WORKDIR /app  
COPY \--from=go-build /Registerator /app/  
COPY \--from=node-build /usr/src/app /app/ui  
ENTRYPOINT ["./Registerator"]  

