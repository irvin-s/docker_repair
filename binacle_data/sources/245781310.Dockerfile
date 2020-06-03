FROM tk0miya/sphinx-base:latest
LABEL maintainer="Sphinx Team <https://github.com/sphinx-doc/sphinx>"

WORKDIR /docs
CMD make html
