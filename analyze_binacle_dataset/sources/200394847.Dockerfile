# STEP 1 build executable binary
FROM golang:alpine as builder
# Create nonroot user
RUN adduser -D -g '' vsphere-graphite-user
# Add ca-certificates
RUN apk --update add ca-certificates

# STEP 2 build a small image from scratch
FROM scratch
LABEL maintainer="cblomart@gmail.com"
# copy password file for users
COPY --from=builder /etc/passwd /etc/passwd
# copy ca-certificates 
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
# copy vsphere-graphite
COPY ./vsphere-graphite /vsphere-graphite
COPY ./vsphere-graphite.json /etc/vsphere-graphite.json
USER vsphere-graphite-user
VOLUME [ "/etc" ]

ENTRYPOINT [ "/vsphere-graphite" ] 
