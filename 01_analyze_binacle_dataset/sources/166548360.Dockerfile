FROM ubuntu:14.04
MAINTAINER FIWARE Adminotech
COPY realxtend-tundra-urho3d-3.0.0-ubuntu-14.04-amd64.deb /tundra.deb
RUN apt-get update
RUN dpkg -i /tundra.deb; exit 0
RUN apt-get -f install -y
RUN rm /tundra.deb
EXPOSE 2345
EXPOSE 2346
