# https://hub.docker.com/r/opensuse/leap/
FROM opensuse/leap:15.0 AS base

RUN zypper -n ref

FROM base AS packages

RUN zypper -n in git python3 python3-dbm rcs

RUN git config --global user.email "you@example.com"
RUN git config --global user.name "Your Name"

RUN zypper -n ar -G https://download.opensuse.org/repositories/Kernel:/tools/openSUSE_Leap_15.0/Kernel:tools.repo
RUN zypper -n in python3-pygit2

RUN zypper -n ar -G https://download.opensuse.org/repositories/home:/benjamin_poirier:/series_sort/openSUSE_Leap_15.0/home:benjamin_poirier:series_sort.repo
RUN zypper -n in --from home_benjamin_poirier_series_sort quilt

FROM packages

VOLUME /scripts

WORKDIR /scripts/git_sort

CMD python3 -m unittest discover -v
