FROM ubuntu
MAINTAINER Matt Erasmus <code@zonbi.org>
RUN addgroup eyewitness
RUN useradd -r -g eyewitness -d /opt/eyewitness -s /sbin/nologin -c "EyeWitness User" eyewitness
RUN apt-get update
RUN apt-get install -yq git wget libffi-dev libssl-dev python-pyicu
RUN git clone https://github.com/ChrisTruncer/EyeWitness.git /opt/EyeWitness
RUN chown eyewitness:eyewitness -R /opt/EyeWitness
WORKDIR /opt/eyewitness/setup
RUN ./setup.sh
COPY RunWitness.sh /usr/local/bin/RunWitness.sh
RUN chmod 775 /usr/local/bin/RunWitness.sh
RUN chown root:eyewitness /usr/local/bin/RunWitness.sh
USER eyewitness
