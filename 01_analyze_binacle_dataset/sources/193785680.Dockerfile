# This file describes the standard way to build neosearch, using docker

FROM google/golang
MAINTAINER Tiago Katcipis <tiagokatcipis@gmail.com> (@tiagokatcipis)

# Grab Go test coverage tools
RUN go get golang.org/x/tools/cmd/present

WORKDIR /presentations

EXPOSE 3999

CMD ["present", "-play=true", "-http=172.17.42.1:3999"]
