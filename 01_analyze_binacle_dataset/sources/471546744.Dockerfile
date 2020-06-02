# start from ubuntu 18.04
FROM ubuntu:bionic
# change the working directory to something unique
WORKDIR /opt/getjacked
# cop the setup file into the container
COPY jack-setup.sh .
# make the script exectuable and run
RUN chmod +x /opt/getjacked/jack-setup.sh && /bin/bash /opt/getjacked/jack-setup.sh
