from golang:1.8.0-alpine  
  
RUN apk add --no-cache bash git openssh  
  
COPY . /go/src/arquitectura/sam_sessions_ms  
  
RUN go get -u github.com/kardianos/govendor  
RUN cd src/arquitectura/sam_sessions_ms && govendor sync  
  
RUN cd src/arquitectura/sam_sessions_ms && go build  
CMD src/arquitectura/sam_sessions_ms/sam_sessions_ms  
  
EXPOSE 8814

