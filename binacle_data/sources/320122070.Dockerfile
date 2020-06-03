FROM debian
MAINTAINER Mephis Pheies <mephistommm@gmail.com>

# the dirname of app in players
ARG PLAYER
ARG VERSION

# add players into PATH
ADD $PLAYER/app /usr/local/bin/

CMD ["/usr/local/bin/app"]
