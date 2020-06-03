FROM debian:jessie
RUN apt-get -yq update && apt-get -yq install wget sudo ruby vim
RUN wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
RUN git config --global user.email kevin@littlejohn.id.au \
  && git config --global user.name "Kevin Littlejohn" \
  && git config --global push.default simple
CMD bash
