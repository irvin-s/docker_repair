# golang image where workspace (GOPATH) configured at /go.  
FROM golang:1.8  
ARG app_env  
ENV APP_ENV $APP_ENV  
  
# copy the local package files to the container workspace  
COPY . /go/src/github.com/devopsdays/gather-flag/accounts  
  
# Setting up working directory  
WORKDIR /go/src/github.com/devopsdays/gather-flag/accounts  
  
# Install dependencies  
RUN go get ./...  
  
CMD if [ ${APP_ENV} = production ]; \  
then \  
accounts; \  
else \  
go get github.com/pilu/fresh && \  
fresh; \  
fi  
  
# Service listens on port 8080.  
EXPOSE 8080  

