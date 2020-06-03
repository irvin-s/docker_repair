FROM mikz/base:precise
MAINTAINER Michal Cichra <michal.cichra@gmail.com>
RUN echo "gem: --no-ri --no-rdoc" > /etc/gemrc

ADD ACCC4CF8.asc /root/

RUN apt-key add /root/ACCC4CF8.asc \
 && echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
 && apt-get update -q -y \
 && apt-get install -q -y libxml2-dev libxslt1-dev \
                          postgresql-client libpq-dev \
                          curl apt-transport-https \
                          build-essential make \
                          supervisor \
 && apt-cleanup

ADD supervisord.conf /etc/supervisor/supervisord.conf

ONBUILD CMD ["supervisord"]

ENV NUM_CPU grep -c processor /proc/cpuinfo
