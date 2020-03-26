FROM ubuntu:trusty
RUN apt-get update && apt-get -y install xvfb stterm scrot xautomation
ADD screenme.sh /screenme.sh
CMD /screenme.sh /vrhs/shot.png
