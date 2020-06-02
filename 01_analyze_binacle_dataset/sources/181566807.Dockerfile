FROM python:2
MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

WORKDIR /static
VOLUME /static

EXPOSE 80

# Run `pip install` before serving if `requirements.txt` exists; then run the static server
CMD ([ -f "requirements.txt" ] && pip install -r requirements.txt); /usr/local/bin/python -m http.server 80
