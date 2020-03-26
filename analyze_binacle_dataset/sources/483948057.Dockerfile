FROM jpetazzo/dind
MAINTAINER Taylor "Nekroze" Lawson

RUN apt-get install -y python-pip aufs-tools
RUN pip install drydock

EXPOSE 80 443 2222

ADD ./drymaster /usr/local/bin/drymaster
ADD ./drypull /usr/local/bin/drypull
RUN chmod +x /usr/local/bin/drymaster /usr/local/bin/drypull

CMD drymaster
