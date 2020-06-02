FROM alpine:3.5  
  
ENV OCTAVE_URL=https://ftp.gnu.org/gnu/octave/octave-4.2.1.tar.lz  
ENV OCTAVE_SIG_URL=https://ftp.gnu.org/gnu/octave/octave-4.2.1.tar.lz.sig  
ENV GPG_KEY=5D36644B  
  
RUN set -xe; \  
\  
mkdir -p /usr/src; \  
cd /usr/src; \  
\  
apk add --no-cache --virtual fetch-dependencies \  
lzip \  
tar \  
openssl \  
gnupg; \  
\  
apk add --no-cache --virtual build-dependencies \  
g++ \  
make \  
gfortran \  
pcre-dev \  
lapack-dev \  
readline-dev \  
perl; \  
\  
wget -O octave.tar.lz "$OCTAVE_URL"; \  
wget -O octave.tar.lz.sig "$OCTAVE_SIG_URL"; \  
\  
gpg --keyserver hkp://keys.gnupg.net --recv-keys "$GPG_KEY"; \  
gpg --verify octave.tar.lz.sig octave.tar.lz; \  
\  
lzip -d octave.tar.lz; \  
tar xvf octave.tar --strip-components=1; \  
\  
./configure; \  
make; \  
make install; \  
make clean; \  
cd /; \  
rm -rf /usr/src; \  
\  
apk del fetch-dependencies;  
  
CMD ["octave"]  

