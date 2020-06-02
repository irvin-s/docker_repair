FROM polyverse/ps-php7.2-apache:47cc0da36dc15aabe928bdf69c2091caab81f736

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y \
      git \
      make \
      autoconf \
      gcc \
      re2c \
      libsqlite3-dev \
	bison \
      libxml2-dev \
      vim \
      ccache \
      apache2 \
      apache2-dev 

RUN a2dismod mpm_event && a2enmod mpm_prefork

WORKDIR $PHP_SRC_PATH
RUN make install

WORKDIR /usr/local/bin/polyscripting/

ENV POLYSCRIPT_PATH /usr/local/bin/polyscripting
ENV PHP_SRC_PATH $PHP_SRC_PATH

COPY ./scripts/ /usr/local/bin/polyscripting/

RUN $POLYSCRIPT_PATH/util/ps-config.sh


