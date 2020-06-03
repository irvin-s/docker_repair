FROM quay.io/travisci/travis:standard

RUN apt-get -y update

RUN wget -qO- https://get.haskellstack.org/ | sh

COPY stack-setup /stack-setup

COPY .project-copy/* /stack-setup/

RUN /bin/bash /stack-setup/setup.sh

RUN rm -rf /stack-setup

VOLUME /escape-artist

WORKDIR /escape-artist

ENTRYPOINT /bin/bash
