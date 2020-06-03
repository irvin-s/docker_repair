FROM shaddock/archlinux:latest
MAINTAINER epheo <github@epheo.eu>

RUN pacman -Syu --noconfirm netcat iproute2 iputils net-tools

EXPOSE 1234

CMD ["env"]
