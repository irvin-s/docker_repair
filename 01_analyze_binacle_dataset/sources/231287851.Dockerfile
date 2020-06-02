FROM strato-build

ENV VERSION 6.0
RUN wget -P /usr/src/ https://ftp.gnu.org/gnu/ncurses/ncurses-${VERSION}.tar.gz
RUN cd /usr/src/ && tar xf ncurses*
RUN cd /usr/src/ncurses* \
    && CPPFLAGS=-P ./configure \
    --with-shared   \
    --without-debug \
    --without-ada   \
    --enable-widec  \
    --enable-overwrite \
    && make

RUN cd /usr/src/ncurses* \
    && make install
