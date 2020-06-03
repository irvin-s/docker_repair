FROM hone/mruby-cli
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --no-install-recommends \
wget
 
RUN mkdir /root/src
WORKDIR /root/src
RUN wget http://www.ijg.org/files/jpegsrc.v9b.tar.gz

RUN tar xvf jpegsrc.v9b.tar.gz
RUN cd jpeg-9b && ./configure --host=i686-w64-mingw32 --prefix=/usr/i686-w64-mingw32 && \
make && make install

 
RUN wget http://zlib.net/zlib-1.2.8.tar.xz && \
wget http://download.sourceforge.net/libpng/libpng-1.6.21.tar.xz

RUN tar xvf zlib-1.2.8.tar.xz && tar xvf libpng-1.6.21.tar.xz

RUN cd zlib-1.2.8  && AR=i686-w64-mingw32-ar RANLIB=i686-w64-mingw32-ranlib CC=i686-w64-mingw32-gcc ./configure --prefix=/usr/i686-w64-mingw32 --static && \
make libz.a && make install
#RUN cd zlib-1.2.8 && CHOST=i686-w64-mingw32 make -f win32/Makefile.gcc libz.a && make install

RUN cd libpng-1.6.21 && ./configure --host=i686-w64-mingw32 --prefix=/usr/i686-w64-mingw32 && \
make && make install

RUN git clone -b ImageMagick-6 --depth 1 https://github.com/ImageMagick/ImageMagick.git
RUN wget https://raw.githubusercontent.com/Alexpux/MINGW-packages/master/mingw-w64-imagemagick/001-relocate.patch && \
wget https://raw.githubusercontent.com/Alexpux/MINGW-packages/master/mingw-w64-imagemagick/002-build-fixes.patch && \
wget https://raw.githubusercontent.com/Alexpux/MINGW-packages/master/mingw-w64-imagemagick/ImageMagick-6.8.8.1-mingw.patch
RUN cp -r ImageMagick ImageMagick_mingw32
RUN apt-get install -y --no-install-recommends mingw-w64-tools
RUN rm /usr/i686-w64-mingw32/lib/lib*.dll.a /usr/i686-w64-mingw32/lib/lib*.la
RUN cd ImageMagick_mingw32 && patch -p1 -i ../ImageMagick-6.8.8.1-mingw.patch && \
patch -p1 -i ../001-relocate.patch && \
patch -p1 -i ../002-build-fixes.patch && \
wget -O Makefile.in https://gist.githubusercontent.com/kjunichi/9ed9b4154bf84cf3d47f/raw/51ebfa4b7a7d4d5ece2063aab58d2ffcc0329ee0/Mingw_Makefile.in && \
./configure --enable-static=yes --enable-shared=no --host=i686-w64-mingw32 --prefix=/usr/i686-w64-mingw32 --without-perl --disable-docs --without-xml && \
touch /usr/i686-w64-mingw32/include/intsafe.h && \
make -j -l 3 && make install
#echo ""
RUN cd jpeg-9b && make distclean && ./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32 && \
make && make install

RUN cd zlib-1.2.8 &&make distclean && \
AR=x86_64-w64-mingw32-ar RANLIB=x86_64-w64-mingw32-ranlib CC=x86_64-w64-mingw32-gcc \
./configure --prefix=/usr/x86_64-w64-mingw32 --static && \
make libz.a && make install

RUN cd libpng-1.6.21 && make distclean && ./configure --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32 && \
make && make install

RUN rm /usr/x86_64-w64-mingw32/lib/lib*.dll.a /usr/x86_64-w64-mingw32/lib/lib*.la
RUN cd ImageMagick_mingw32 && make distclean && \
./configure --enable-static=yes --enable-shared=no --host=x86_64-w64-mingw32 --prefix=/usr/x86_64-w64-mingw32 \
--without-perl --disable-docs --without-xml && \
touch /usr/x86_64-w64-mingw32/include/intsafe.h && \
make -j -l 2 && make install

# Darwin

RUN cd jpeg-9b && make distclean && CC=x86_64-apple-darwin14-clang LD=x86_64-apple-darwin14-ld ./configure --host=x86_64-apple-darwin14 --prefix=/usr/x86_64-apple-darwin14 && \
CFLAGS="-fPIC" make && make install

RUN cd zlib-1.2.8 &&make distclean && \
AR=x86_64-apple-darwin14-ar RANLIB=x86_64-apple-darwin14-ranlib CC=x86_64-apple-darwin14-clang \
./configure --prefix=/usr/x86_64-apple-darwin14 --static && \
make libz.a && make install

RUN cd libpng-1.6.21 && make distclean && \
CC=x86_64-apple-darwin14-clang ./configure --host=x86_64-apple-darwin14 --prefix=/usr/x86_64-apple-darwin14 && \
make && make install

RUN rm /usr/x86_64-apple-darwin14/lib/lib*.dylib /usr/x86_64-apple-darwin14/lib/lib*.la
RUN cd ImageMagick && \
OSXCROSS_PKG_CONFIG_PATH=/usr/x86_64-apple-darwin14/lib/pkgconfig \
LDFLAGS=-L/usr/x86_64-apple-darwin14/lib CFLAGS=-I/usr/x86_64-apple-darwin14/include \
CC=x86_64-apple-darwin14-clang CXX=x86_64-apple-darwin14-clang++ \
./configure --host=x86_64-apple-darwin14 --prefix=/usr/x86_64-apple-darwin14 \
--enable-static=yes --enable-shared=no --without-perl --disable-docs --without-xml &&\
make -j -l 2 && make install

RUN cd jpeg-9b && make distclean && CC=i386-apple-darwin14-clang LD=i386-apple-darwin14-ld ./configure --host=i386-apple-darwin14 --prefix=/usr/i386-apple-darwin14 && \
CFLAGS="-fPIC" make && make install

RUN cd zlib-1.2.8 &&make distclean && \
AR=i386-apple-darwin14-ar RANLIB=i386-apple-darwin14-ranlib CC=i386-apple-darwin14-clang \
./configure --prefix=/usr/i386-apple-darwin14 --static && \
make libz.a && make install

RUN cd libpng-1.6.21 && make distclean && \
CC=i386-apple-darwin14-clang ./configure --host=i386-apple-darwin14 --prefix=/usr/i386-apple-darwin14 && \
make && make install

RUN rm /usr/i386-apple-darwin14/lib/lib*.dylib /usr/i386-apple-darwin14/lib/lib*.la
RUN cd ImageMagick && \
make distclean && \
OSXCROSS_PKG_CONFIG_PATH=/usr/i386-apple-darwin14/lib/pkgconfig \
LDFLAGS=-L/usr/i386-apple-darwin14/lib CFLAGS=-I/usr/i386-apple-darwin14/include \
CC=i386-apple-darwin14-clang CXX=i386-apple-darwin14-clang++ \
./configure --host=i386-apple-darwin14 --prefix=/usr/i386-apple-darwin14 \
--enable-static=yes --enable-shared=no --without-perl --disable-docs --without-xml &&\
make -j -l 2 && make install

# Linux

RUN cd jpeg-9b && make distclean && CFLAGS="-m32" ./configure --prefix=/usr/i686-pc-linux-gnu && \
make && make install

RUN cd zlib-1.2.8 && make distclean && \
CFLAGS="-m32" ./configure --prefix=/usr/i686-pc-linux-gnu --static && \
make libz.a && make install

RUN cd libpng-1.6.21 && make distclean && \
CFLAGS="-m32 -I/usr/i686-pc-linux-gnu/include" LDFLAGS="-L/usr/i686-pc-linux-gnu/lib" ./configure --prefix=/usr/i686-pc-linux-gnu && \
make && make install

RUN rm /usr/i686-pc-linux-gnu/lib/lib*.so* /usr/i686-pc-linux-gnu/lib/lib*.la
RUN cd ImageMagick && \
PKG_CONFIG_PATH=/usr/i686-pc-linux-gnu/lib/pkgconfig \
CXXFLAGS="-m32 -I/usr/i686-pc-linux-gnu/include" CFLAGS="-m32 -I/usr/i686-pc-linux-gnu/include" LDFLAGS="-L/usr/i686-pc-linux-gnu/lib" \
./configure --prefix=/usr/i686-pc-linux-gnu \
--enable-static=yes --enable-shared=no --without-perl --disable-docs --without-xml &&\
make -j -l 2 && make install

RUN cd jpeg-9b && make distclean && ./configure --prefix=/usr/x86_64-pc-linux-gnu && \
make && make install

RUN cd zlib-1.2.8 && make distclean && \
./configure --prefix=/usr/x86_64-pc-linux-gnu --static && \
make libz.a && make install

RUN cd libpng-1.6.21 && make distclean && \
CFLAGS="-I/usr/x86_64-pc-linux-gnu/include" LDFLAGS="-L/usr/x86_64-pc-linux-gnu/lib" ./configure --prefix=/usr/x86_64-pc-linux-gnu --disable-shared --enable-static && \
make && make install

RUN rm /usr/x86_64-pc-linux-gnu/lib/lib*.so* /usr/x86_64-pc-linux-gnu/lib/lib*.la
RUN cd ImageMagick && \
PKG_CONFIG_PATH=/usr/x86_64-pc-linux-gnu/lib/pkgconfig \
CFLAGS="-I/usr/x86_64-pc-linux-gnu/include" LDFLAGS="-L/usr/x86_64-pc-linux-gnu/lib" \
./configure --prefix=/usr/x86_64-pc-linux-gnu \
--enable-static=yes --enable-shared=no --without-perl --disable-docs --without-xml &&\
make -j -l 2 && make install
