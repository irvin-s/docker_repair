#@[--DOCKTITUDE-SCRIPT
#@ #!/bin/sh -
#@ 
#@ docker run -it --rm --name libreoffice \
#@   -e DISPLAY=unix$DISPLAY \
#@   -e GDK_SCALE \
#@   -e GDK_DPI_SCALE \
#@   -v /tmp/.X11-unix:/tmp/.X11-unix \
#@   -v /etc/localtime:/etc/localtime:ro \
#@   libreoffice
#@DOCKTITUDE-SCRIPT--]
#
FROM debian:jdk8-ui
MAINTAINER demo@docktitude.com

# Hierarchy demo (content omitted for brevity)
