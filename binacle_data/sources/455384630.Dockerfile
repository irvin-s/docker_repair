# vim: set filetype=dockerfile:

FROM golang:1.8
MAINTAINER dbarroso@dravetech.com

RUN go get github.com/osrg/gobgp/gobgpd;\
	go get github.com/osrg/gobgp/gobgp

COPY gobgpd_*.conf ./

ENTRYPOINT ["gobgpd"]
