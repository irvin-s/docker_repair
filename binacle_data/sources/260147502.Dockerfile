FROM alpine

ADD ./mold /usr/bin/

CMD [ "/usr/bin/mold" ]
