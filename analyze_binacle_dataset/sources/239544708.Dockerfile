FROM python:3.6

ARG BONOBO_VERSION

RUN apt-get -y update \
 && apt-get -y install git make vim sudo \
 && pip install -U pip wheel virtualenv \
 && useradd -m bonobo

ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini

RUN chmod +x /sbin/tini \
 && cd /home/bonobo \
 && echo "bonobo (== ${BONOBO_VERSION})" > requirements.txt \
 && sudo -u bonobo virtualenv . \
 && sudo -u bonobo mkdir -p src \
 && sudo -u bonobo bin/pip install -r requirements.txt \
 && (echo 'export PS1="🐵  \w "'; echo '. /home/bonobo/bin/activate'; echo 'alias l="ls -lsah"') >> /home/bonobo/.bashrc

ADD ./entrypoint.sh /usr/local/bin/

USER bonobo
WORKDIR /home/bonobo

ENV PYTHONSTARTUP /home/bonobo/.pythonrc
ADD ./pythonrc.py ${PYTHONSTARTUP}

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/entrypoint.sh"]
