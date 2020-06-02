# Run Mutt from a container
# Inspired by https://github.com/jessfraz/dockerfiles

# docker run -it \
#	-v /etc/localtime:/etc/localtime:ro \
#	-v ${HOME}/.gnupg:/home/mutty/.gnupg \
#	-v ${HOME}/.mutt:/home/mutty/.mutt \
#	--name mutt \
#	gianarb/mutt
#
FROM alpine:edge
LABEL maintainer "Gianluca Arbezzano <gianarb92@gmail.com>"

RUN addgroup -g 1000 mutty \
	&& adduser -D -h /home/mutty -G mutty -u 1000 mutty

RUN apk --no-cache add \
	ca-certificates \
	elinks \
	git \
	gnupg1 \
	lynx \
	mutt \
	mutt-doc \
	vim

ENV BROWSER lynx

USER mutty
ENV HOME /home/mutty
#ENV TERM xterm-256color
ENV LANG C.UTF-8

CMD ["mutt", "-F", "~/.mutt/muttrc"]
