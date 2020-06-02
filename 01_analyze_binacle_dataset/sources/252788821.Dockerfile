# Git-lfs client build  
FROM iron/go:dev  
MAINTAINER Giles <giles@dringtech.com>  
  
RUN apk update && apk add bash  
  
RUN go get -v github.com/git-lfs/git-lfs  
  
# TESTS RETURN NON-ZERO?  
# WORKDIR /go/src/github.com/git-lfs/git-lfs/  
# RUN ./script/cibuild  
# RUNTIME  
FROM iron/python:3.5  
MAINTAINER Giles <giles@dringtech.com>  
  
RUN apk update && apk add git jq  
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3  
RUN pip install requests  
COPY \--from=0 /go/bin/git-lfs /usr/local/bin/git-lfs  
COPY git_lfs_report.py /usr/local/bin/  
RUN chmod +x /usr/local/bin/git_lfs_report.py  

