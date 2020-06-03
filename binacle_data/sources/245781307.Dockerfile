FROM tk0miya/sphinx-base:latest
LABEL maintainer="Sphinx Team <https://github.com/sphinx-doc/sphinx>"

RUN apt-get install -y \
      latexmk \
      lmodern \
      texlive-latex-recommended \
      texlive-latex-extra \
      texlive-fonts-recommended \
      texlive-fonts-extra \
      texlive-lang-cjk \
      texlive-lang-japanese \
      texlive-luatex \
      texlive-xetex \
 && apt-get autoremove \
 && apt-get clean
