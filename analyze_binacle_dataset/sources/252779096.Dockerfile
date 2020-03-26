FROM golang  
RUN go get github.com/beego/bee  
RUN go get github.com/aws/aws-sdk-go/aws  
RUN go get github.com/aws/aws-sdk-go/service/s3  
RUN go get github.com/aws/aws-sdk-go/aws/awserr  
RUN go get github.com/aws/aws-sdk-go/aws/awsutil  
RUN go get github.com/lenfree/awsLaCapa  
WORKDIR /go/src/github.com/lenfree/awsLaCapa  
CMD ["bee", "run"]  

