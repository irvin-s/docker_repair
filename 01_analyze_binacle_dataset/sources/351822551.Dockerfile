FROM nachtmaar/androlyze_base:latest
MAINTAINER Nils Schmidt <schmidt89@informatik.uni-marburg.de>

ENV WORK_DIR /usr/share/easy-rsa/

# install first
RUN apt-get update \
	&& apt-get install -y --no-install-recommends easy-rsa

# then overwrite files
ADD . $WORK_DIR

WORKDIR $WORK_DIR

CMD ./create_pki.sh

VOLUME [$WORK_DIR/keys]