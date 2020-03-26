FROM starefossen/github-pages

ENV HOME=/usr/src/app

WORKDIR ${HOME}

EXPOSE 4000 80
CMD jekyll serve -d /_site --watch --force_polling -H 0.0.0.0 -P 4000
