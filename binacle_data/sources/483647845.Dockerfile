FROM mazzolino/armhf-debian:wheezy

RUN apt-get update
RUN apt-get install -y --force-yes ruby ruby-dev gcc make python python-dev
RUN gem install fpm --no-ri --no-rdoc
RUN uname -a

CMD ["/bin/bash"]