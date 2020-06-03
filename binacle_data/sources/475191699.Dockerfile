FROM golang:1.5
MAINTAINER Matt Oswalt <matt@keepingitclassless.net> (@mierdin)

LABEL description="A very simple Go application"

ENV PATH /go/bin:$PATH

# Copy source code
COPY ./src /go/src

RUN cd src && go build -o ../bin/hellogo

EXPOSE 80

ENTRYPOINT ["hellogo"]