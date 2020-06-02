FROM scratch

COPY ./run /bin/run
COPY ./run /bin/bash
CMD ["/bin/run"]

