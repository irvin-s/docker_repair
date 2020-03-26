FROM scratch
ADD {image} /

COPY {deb_file} commands.sh /tmp/
RUN /tmp/commands.sh
USER {user}
WORKDIR {workdir}
CMD {cmd}
