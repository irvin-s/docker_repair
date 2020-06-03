FROM google/cloud-sdk:alpine

ENV PATH /google-cloud-sdk/bin:$PATH
RUN apk --no-cache add rsync
COPY sync.sh .

