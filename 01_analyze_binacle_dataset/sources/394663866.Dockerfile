FROM fcoelho/phabricator-base

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

ADD run.sh /run.sh

VOLUME ["/phabricator", "/var/repo"]

CMD ["/run.sh"]
