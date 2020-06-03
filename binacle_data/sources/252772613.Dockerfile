FROM billyteves/alpine-golang-glide:1.2.0  
ADD . /go/src/app  
WORKDIR /go/src/app  
RUN glide install  
RUN go install .  
ENTRYPOINT /go/bin/app  
EXPOSE 3000

