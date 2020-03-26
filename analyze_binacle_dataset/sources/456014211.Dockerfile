FROM ioft/i386-ubuntu:16.04

RUN apt-get update && apt-get install -y qt5-qmake qtbase5-dev libbotan1.10-dev libappindicator-dev

