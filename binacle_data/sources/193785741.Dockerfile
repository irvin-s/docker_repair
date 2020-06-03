FROM google/golang
MAINTAINER Tiago Katcipis <tiagokatcipis@gmail.com> (@tiagokatcipis)

# Grab Go test coverage tools
RUN go get golang.org/x/tools/cmd/present

WORKDIR /presentations

EXPOSE 3999

CMD ["present", "-play=true"] 
