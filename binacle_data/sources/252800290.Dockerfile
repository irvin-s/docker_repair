FROM golang  
  
ENV HTTP_PORT ":3000"  
ARG gin_mode="release"  
ENV GIN_MODE="release"  
ENV GITHUB_TOKEN=""  
ENV GITHUB_ORG=""  
ENV GITHUB_REPO=""  
ENV GITHUB_LABEL_PREFIX=""  
ENV GITHUB_LABEL_BROKEN=""  
ENV DATABASE_PATH=""  
ENV UPDATE_TIME=60  
WORKDIR /go/src/github.com/DoESLiverpool/status  
COPY . .  
  
RUN go get ./  
RUN go build  
  
CMD [ "./status" ]  
  
EXPOSE 3000

