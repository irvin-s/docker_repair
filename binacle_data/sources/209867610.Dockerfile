from silex/emacs:26.1-alpine
MAINTAINER Mika Vilpas "mika.vilpas@gmail.com"

# install cask, the dependency manager
run apk add git python
run curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
env PATH="/root/.cask/bin/:${PATH}"

workdir /evil-lispy/
CMD [ "sh" ]
