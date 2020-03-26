FROM python:2.7-stretch

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser

RUN mkdir -p /spr4g
RUN chown appuser /spr4g
USER appuser
WORKDIR /spr4g

RUN git clone https://github.com/sio2project/sioworkers.git

USER root
RUN pip install filetracker
RUN pip install -e sioworkers/
RUN pip install librabbitmq

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y sudo libc6:i386 libstdc++6:i386 libdwarf1:i386

# Some linker hacks that seem to be needed
RUN ln -s /usr/lib/i386-linux-gnu/libdwarf.so.1 /usr/lib/i386-linux-gnu/libdwarf.so
RUN ln -s /usr/lib/i386-linux-gnu/libelf-0.168.so /usr/lib/i386-linux-gnu/libelf.so.0

# For debugging:
# RUN apt-get update
# RUN apt-get -y install less vim wget netcat tcpdump dnsutils

USER appuser

ADD supervisor.sh /spr4g/sioworkers/supervisor.sh
ADD supervisord-conf-vars.conf /spr4g/sioworkers/config/supervisord-conf-vars.conf
ADD supervisord.conf /spr4g/sioworkers/config/supervisord.conf
ADD logging.json /spr4g/sioworkers/config/logging.json
ADD start.sh /spr4g/sioworkers/start.sh

WORKDIR /spr4g/sioworkers
RUN mkdir -p logs
RUN mkdir -p pidfiles

# We need root privileges to move resolf.conf to /etc/resolv.conf.
# We switch back to appuser in start.sh
USER root
RUN chmod +x /spr4g/sioworkers/start.sh
RUN chmod +x /spr4g/sioworkers/supervisor.sh
ENTRYPOINT ./start.sh
