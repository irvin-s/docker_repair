FROM silarsis/base
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>
RUN apt-get -yq update && apt-get -yq upgrade
RUN apt-get -yq install python-software-properties software-properties-common python g++ make git
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -yq update
RUN apt-get -yq install nodejs
#RUN git clone https://github.com/rknLA/irc-slack-echo.git
#WORKDIR /irc-slack-echo
RUN git clone https://github.com/jimmyhillis/slack-irc-plugin.git
WORKDIR /slack-irc-plugin
RUN npm install
RUN node .
CMD ["/bin/bash"]
