FROM golang:1.10-alpine
    
    
RUN \
    apk update && \
    apk upgrade && \
    apk add git && \
    go get -d github.com/Azure/azure-event-hubs-go && \
    go get -d github.com/stretchr/testify/assert && \
    go get -d github.com/BCDevOps/openshift-tools/monitoring/az-provisioning-event-collector/azcollect && \
    cd $GOPATH/src/github.com/BCDevOps/openshift-tools/monitoring/az-provisioning-event-collector/ && \
    go test -v ./... && \
    go install github.com/BCDevOps/openshift-tools/monitoring/az-provisioning-event-collector/azcollect
