FROM ubuntu

COPY . /srv/wineappimage

WORKDIR /srv/wineappimage
RUN /srv/wineappimage/deployscript/debian-winedeploy.sh