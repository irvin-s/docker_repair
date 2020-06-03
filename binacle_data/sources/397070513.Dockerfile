
# Base image for Mojolicious apps
# It uses the latest oficcial Docker Perl image and the latest version of Mojolicious on cpan.
# By latest, I mean the latest when this image was build and uploaded to the docker hub. If you build it yourself, you get a the latest availible when you build it (duh).
# Not sure if this is a good way of doing things, especially since there's little testing going on. Another way of doing it would be to pin the version on Perl, Mojolicious and other modules  to make building the image yourself more repeatable. OTOH hand, Docker kind of gives you this with images and tags.

# Goals:
#  - Be "runable" so it can be used as an easy way to run a Mojolicious app without having to install anything
#  - Be a good base image for Mojolicious apps

## Todo: Include *a few* more comon perl modules

## Running: 
# - Copy the Mojolicious app into the image / container
# - Mount a volume with the app. 

## Building from Dockerfile:
# docker build -t FOO/mojolicious-latest .
# (you might want to use --rm or --no-cache to ensure you get the latest versions?)

FROM perl:latest
MAINTAINER Øyvind Skaar

# App::cpanminus is now in the official perl Docker image
# Use it to install Perl modules
RUN cpanm Mojolicious
RUN cpanm EV

# Define mountable directories.
# this seems rather pointless?
VOLUME ["/app"]

# this seems rather pointless?
EXPOSE 3000

WORKDIR /app

#ENTRYPOINT ["nginx"]
#CMD ["-c", "/etc/nginx/proxy.conf"]
