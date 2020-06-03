FROM jolicode/hhvm

ENV HOME=/root

ADD bin/entrypoint /sbin/entrypoint
RUN sudo chmod +x /sbin/entrypoint

ADD bin/atoum /usr/local/bin/atoum
RUN sudo chmod +x /usr/local/bin/atoum

ADD https://raw.githubusercontent.com/atoum/atoumsay/master/atoumsay /usr/local/bin/atoum-say
RUN sudo chmod +x /usr/local/bin/atoum-say

RUN echo "<?php" | sudo tee /.autoloaders.atoum.php
RUN echo "<?php" | sudo tee /.extensions.atoum.php
ADD files/.atoum.php /.atoum.php
ADD files/.bootstrap.atoum.php /.bootstrap.atoum.php

RUN sudo composer self-update
RUN sudo composer global require atoum/atoum:~2.0

VOLUME /src
WORKDIR /src

ENTRYPOINT ["/sbin/entrypoint"]
