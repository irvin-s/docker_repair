FROM bobpace/devbox
MAINTAINER Bob Pace <bob.pace@gmail.com>

USER root
RUN apt-get update \
    && apt-get install -y \
    octave \
    octave-info \
    && rm -rf /var/lib/apt/lists/*

USER devuser

CMD ["/bin/zsh"]
