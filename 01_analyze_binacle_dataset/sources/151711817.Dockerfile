FROM       ubuntu:12.04
MAINTAINER Nate Jones <nate@endot.org>

RUN apt-get update
RUN apt-get install python-pip python-dev build-essential libyaml-dev git -y

RUN pip install mkdocs

ADD run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
