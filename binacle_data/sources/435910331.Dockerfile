FROM ubuntu

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt-get update && apt-get -y upgrade

# remove this
RUN apt-get install -y vim netcat

RUN apt-get install -y python3 python3-pip
RUN pip3 install flask gevent

#create ctf-user
RUN groupadd -r ctf && useradd -r -g ctf ctf
RUN mkdir -p /home/ctf/static
COPY adminpass flag server.py util.py /home/ctf/
COPY static /home/ctf/static/


### #set some proper permissions
RUN chown -R root:ctf /home/ctf
RUN chmod -R 750 /home/ctf

EXPOSE 8000
WORKDIR /home/ctf
USER ctf

CMD /home/ctf/server.py
