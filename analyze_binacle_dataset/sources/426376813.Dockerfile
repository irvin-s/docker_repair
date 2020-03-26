#// Ubuntu Release Agnostic update + upgrade.
#//
#// Deprecate:
#// RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
#// 
#// Better: see comment by tobstarr
#// http://crosbymichael.com/dockerfile-best-practices.html

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list

RUN apt-get update
RUN apt-get upgrade -y
