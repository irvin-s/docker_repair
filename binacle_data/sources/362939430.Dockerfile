FROM golang:1.5
MAINTAINER Julien Vehent
ENV PROJECT=go.mozilla.org/userplex
ENV PROJECTNAME=userplex
ENV GO15VENDOREXPERIMENT=1

ADD . /go/src/$PROJECT

RUN mkdir /etc/$PROJECTNAME
ADD config.yaml /etc/$PROJECTNAME/

RUN groupadd -r $PROJECTNAME && useradd -r -g $PROJECTNAME $PROJECTNAME
USER $PROJECTNAME

RUN go install $PROJECT

ENTRYPOINT /go/bin/$PROJECTNAME
