FROM tk0miya/sphinx-base-pdf:latest
LABEL maintainer="Sphinx Team <https://github.com/sphinx-doc/sphinx>"

WORKDIR /docs
CMD make latexpdf
