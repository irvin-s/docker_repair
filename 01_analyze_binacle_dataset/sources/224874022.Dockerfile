FROM scratch
MAINTAINER Manfred Touron (@moul)
ADD ./entrypoint /usr/bin/entrypoint
ENTRYPOINT ["/usr/bin/entrypoint"]
