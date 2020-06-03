FROM golang:1.9.0 as build  
  
ARG PROJECT_PATH=github.com/ciena/spanneti  
ARG FILE_NAME=spanneti  
  
WORKDIR /go/src/$PROJECT_PATH  
  
# get and install dependencies  
RUN go get -u github.com/kardianos/govendor  
COPY vendor/vendor.json vendor/  
RUN govendor sync -v  
RUN govendor install -tags netgo +vendor  
  
# get git status  
ARG GIT_BRANCH  
ARG GIT_COMMIT_NUM  
ARG GIT_COMMIT  
ARG CHANGED  
  
# bring in source files  
COPY . ./  
  
# build static binary  
RUN go build -v -tags netgo \  
\--ldflags "-extldflags \"-static\" \  
-X \"$PROJECT_PATH/spanneti.GIT_BRANCH=$GIT_BRANCH\" \  
-X \"$PROJECT_PATH/spanneti.GIT_COMMIT_NUM=$GIT_COMMIT_NUM\" \  
-X \"$PROJECT_PATH/spanneti.GIT_COMMIT=$GIT_COMMIT\" \  
-X \"$PROJECT_PATH/spanneti.CHANGED=$CHANGED\"" \  
-o build/$FILE_NAME main.go  
  
# create final container  
FROM alpine:3.5  
ARG PROJECT_PATH=github.com/ciena/spanneti  
ARG FILE_NAME=spanneti  
COPY \--from=build /go/src/$PROJECT_PATH/build/$FILE_NAME /bin/$FILE_NAME  
CMD ["spanneti"]  

