FROM scratch
MAINTAINER CenturyLink Labs <clt-labs-futuretech@centurylink.com>
EXPOSE 8001

COPY panamax-kubernetes-adapter-go /

ENTRYPOINT ["/panamax-kubernetes-adapter-go"]
