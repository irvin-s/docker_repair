FROM yebyen/urbinit:base-i686
RUN /usr/bin/apt-get clean
ADD urbit-i386.diff /
RUN git clone https://github.com/urbit/urbit /urbit && cd /urbit && git clone https://github.com/urbit/arvo && patch -p1 < /urbit-i386.diff
RUN curl -o /urbit/urbit.pill https://bootstrap.urbit.org/latest.pill
