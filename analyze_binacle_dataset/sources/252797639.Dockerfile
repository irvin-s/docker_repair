FROM alpine:3.4  
ADD *.go /  
RUN apk update \  
&& apk add bash git go ca-certificates \  
&& ORG_PATH="github.com/Financial-Times" \  
&& REPO_PATH="${ORG_PATH}/coco-mongodb-backup" \  
&& export GOPATH=/gopath \  
&& mkdir -p $GOPATH/src/${ORG_PATH} \  
&& ln -s ${PWD} $GOPATH/src/${REPO_PATH} \  
&& cd $GOPATH/src/${REPO_PATH} \  
&& go get -t \  
&& go test \  
&& go build ${REPO_PATH} \  
&& apk del go git \  
&& rm -rf $GOPATH /var/cache/apk/*  
  
CMD exec ./coco-mongodb-backup \  
-mongoDbPort=$MONGODB_PORT \  
-mongoDbHost=$MONGODB_HOST \  
-awsAccessKey=$AWS_ACCESS_KEY \  
-awsSecretKey=$AWS_SECRET_KEY \  
-bucketName=$BUCKET_NAME \  
-dataFolder=$DATA_FOLDER \  
-s3Domain=$S3_DOMAIN \  
-env=$ENV_TAG  

