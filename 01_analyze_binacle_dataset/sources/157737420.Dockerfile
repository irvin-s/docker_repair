# Image on top of mesos-overlay-modules-base
FROM mesosphere/mesos-overlay-modules-base

# This script is responsible for pulling a PR, building a
# mesos-overlay image and running all the unit-tests. 
COPY build_overlay.sh /

WORKDIR /

ENTRYPOINT ["/build_overlay.sh"]

