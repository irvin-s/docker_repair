FROM hone/mruby-cli
RUN apt-get update && apt-get install xclip xvfb -y
ENV DISPLAY :1.0
