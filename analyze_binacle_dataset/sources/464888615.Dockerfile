FROM golang:1.11-alpine AS builder

RUN apk update && apk add git && apk add ca-certificates && apk add make
RUN adduser -D -g '' bloom

WORKDIR /signal
COPY . ./
RUN make static

####################################################################################################
## Image
####################################################################################################

FROM scratch

COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /signal/dist/signal /signal/signal
COPY ca-certificates.crt /etc/ssl/certs/
# COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY analytics.min.js /signal/

USER bloom
WORKDIR /signal

EXPOSE 8080
CMD ["./signal"]
