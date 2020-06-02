FROM tvial/docker-mailserver

ARG SIGNING_KEY="unset"
ARG PASSPHRASE="unset"

RUN apt-get update -qq && apt-get install -y --no-install-recommends sudo cpanminus make git &&\
  apt-get clean && rm -rf /tmp/* /var/lib/apt/lists/* &&\
  adduser --home /var/opt/gpgit --disabled-password --disabled-login --gecos "" gpgit &&\
  mkdir -p /tmp/keys

COPY bin/* /tmp/
COPY keys/* /tmp/keys/

RUN mkdir -p /var/opt/gpgit/.gnupg && \
  chown gpgit:gpgit /var/opt/gpgit/.gnupg && chmod 700 /var/opt/gpgit/.gnupg && \
  chmod 755 /tmp/trust_keys.sh
    
RUN ["/bin/bash", "-c", "for key in $(ls /tmp/keys); do /tmp/trust_keys.sh ${key}; done"]
    
RUN cpanm Mail::GnuPG && \
  rm -rf /tmp/*

WORKDIR /opt

RUN git clone https://gitlab.com/ConorIA/gpgit.git /opt/gpgit &&\
    lnno=$(( $(grep -n "127.0.0.1:10025 inet" /etc/postfix/master.cf | cut -d : -f 1) + 1 )) && \
    sed -i "${lnno}s/.*/  -o content_filter=gpgit-pipe/" /etc/postfix/master.cf && \
    echo "" >> /etc/postfix/master.cf &&\
    echo "gpgit-pipe   unix    -   n      n       -       -       pipe" >> /etc/postfix/master.cf &&\
    echo "  flags=Rq user=gpgit argv=/opt/gpgit/gpgit_postfix.sh -oi -f \${sender} \${recipient}" >> /etc/postfix/master.cf

COPY bin/gpgit_postfix.sh /opt/gpgit/gpgit_postfix.sh

RUN chmod 755 /opt/gpgit/gpgit_postfix.sh &&\
    if [ "${SIGNING_KEY}" != "unset"  ]; then \
      sed -i "s/GPGIT_ARGS=''/GPGIT_ARGS\=\'--encrypt-mode pgpmime-sign --sign-key $SIGNING_KEY --sign-pass $PASSPHRASE\'/g" /opt/gpgit/gpgit_postfix.sh; \
    fi
