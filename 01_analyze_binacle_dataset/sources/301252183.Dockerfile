FROM alpine
ADD k8guard-discover /
EXPOSE 3000
ENTRYPOINT ["/k8guard-discover"]


# Commmenting out the multistage build
# Unfortunately I have to revert multistage dockerfile with a lot of saddness
# because minikube uses a very old version of docker in the virtual machine they provide
# and that breaks buidling k8guard for minikube locally,
# altenrative solution would have been providing two dockerfiles one for docker-compose one for minikube
# for the sake of unity, I compromise for not using multistage dockerfile for now.
# with a lot of saddness. :(
# https://github.com/k8guard/k8guard-start-from-here/issues/50


# FROM varikin/golang-glide-alpine AS build
# WORKDIR /go/src/github.com/k8guard/k8guard-discover
# COPY ./ ./
# RUN apk -U add make
# RUN make deps build
#
# FROM alpine
# RUN apk -U add ca-certificates
# COPY --from=build /go/src/github.com/k8guard/k8guard-discover/k8guard-discover /
# EXPOSE 3000
# ENTRYPOINT ["/k8guard-discover"]
