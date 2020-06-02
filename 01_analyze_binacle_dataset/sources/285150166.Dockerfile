FROM python:3.6-alpine3.6
RUN apk add --no-cache util-linux

ADD start-script.py /usr/local/bin/start-script.py

ENV MOUNT_SCRIPT /usr/local/bin/mounter.py

ADD mounter.py  ${MOUNT_SCRIPT}

CMD /usr/local/bin/start-script.py
