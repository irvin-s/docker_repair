# vcn - vChain CodeNotary
# 
# Copyright (c) 2018-2019 vChain, Inc. All Rights Reserved.
# This software is released under GPL3.
# The full license information can be found under:
# https://www.gnu.org/licenses/gpl-3.0.en.html

FROM golang:1.12-stretch as build
WORKDIR /src
COPY . .
RUN GOOS=linux GOARCH=amd64 make static

FROM alpine:3.9 as ca
RUN apk add --no-cache \
		ca-certificates

FROM scratch
COPY --from=ca /etc/ssl/certs /etc/ssl/certs
COPY --from=build /src/vcn /bin/vcn

ENTRYPOINT [ "/bin/vcn" ]