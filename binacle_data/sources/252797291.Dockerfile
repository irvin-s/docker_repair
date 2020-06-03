FROM library/ubuntu:bionic AS build  
  
ENV LANG=C.UTF-8  
  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get install -y \  
software-properties-common \  
apt-utils  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get install -y \  
fdupes  
  
RUN mkdir /build /rootfs  
WORKDIR /build  
RUN apt-get download \  
libgdbm5 \  
perl-base \  
perl-modules-5.26 \  
libperl5.26 \  
perl  
RUN find *.deb | xargs -I % dpkg-deb -x % /rootfs  
  
WORKDIR /rootfs  
RUN rm -rf \  
etc \  
usr/share/doc \  
usr/share/man \  
usr/share/lintian \  
usr/lib/x86_64-linux-gnu/perl/debian-config-data-* \  
usr/lib/x86_64-linux-gnu/perl/cross-config-* \  
&& ln -sf perl5.26-x86_64-linux-gnu usr/bin/perl \  
&& ln -sf perl5.26-x86_64-linux-gnu usr/bin/perl5.26.1 \  
&& ln -sf cpan5.26-x86_64-linux-gnu usr/bin/cpan \  
&& fdupes -rnq1 \  
usr/lib/x86_64-linux-gnu/perl \  
usr/lib/x86_64-linux-gnu/perl-base \  
usr/share/perl \  
| xargs -I % sh -c "ln -sf /%"  
  
WORKDIR /  
  
  
FROM clover/common  
  
ENV LANG=C.UTF-8  
  
COPY --from=build /rootfs /  

