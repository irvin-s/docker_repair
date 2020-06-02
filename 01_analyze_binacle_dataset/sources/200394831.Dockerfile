# STEP 1 build executable binary
FROM alpine as builder
# Create nonroot user
RUN adduser -D -g '' vsphere-graphite-user
# Add ca-certificates
RUN apk --update add ca-certificates

# STEP 2 build a small image from scratch
FROM scratch
ARG os=linux
ARG arch=amd64
LABEL maintainer="cblomart@gmail.com"
# copy password file for users
COPY --from=builder /etc/passwd /etc/passwd
# copy ca-certificates 
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
# copy vsphere-graphite
COPY ./releases/$os/$arch/vsphere-graphite /vsphere-graphite
# copy config
COPY ./vsphere-graphite-example.json /etc/vsphere-graphite.json
# run as vpshere-graphite-user
USER vsphere-graphite-user
# use /etc as volume for configuration
VOLUME [ "/etc" ]
# start vsphere-graphite
ENTRYPOINT [ "/vsphere-graphite" ] 
