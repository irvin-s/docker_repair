FROM python:3.6

ARG UNAME=appuser
ARG UID
ARG GID
RUN groupadd -g ${GID} ${UNAME}
RUN useradd -m -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}

ADD requirements.txt /
RUN pip install -r /requirements.txt
CMD [ "python", "/pybot/main.py" ]
