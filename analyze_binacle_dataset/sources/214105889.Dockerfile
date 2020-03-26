FROM pandastrike/arch_plus
MAINTAINER David Harper (david@pandastrike.com)
#===============================================================================
# Node.js
#===============================================================================
# This Dockerfile describes a Node.js web server.

# Arch-Plus is a container with all this stuff installed to speed dev iterations.
# However, when running production, uncomment these lines and get the latest.
#RUN pacman -Syu --noconfirm
#RUN pacman-db-upgrade
#RUN pacman -S --noconfirm jre7-openjdk-headless wget vim tmux git nodejs
#RUN npm install -g coffee-script

# Pull in your source code.
RUN git clone -b {{{app.branch}}} git://hook.{{{cluster.name}}}.cluster:2001/repos/{{{app.name}}} {{{app.name}}}
RUN cd {{{app.name}}} && npm install

# Pull in any data that the user specified in the huxley.yaml
RUN git clone git://hook.{{{cluster.name}}}.cluster:2001/files
RUN if [ -e files/{{{app.name}}}.tar.gz ]; then            \
      echo "Extracting privileged files.";                 \
      cp files/{{{app.name}}}.tar.gz {{{app.name}}};       \
      cd {{{app.name}}} && tar -xzf {{{app.name}}}.tar.gz; \
    else                                                   \
      echo "No privileged data found.";                    \
      exit 0;                                              \
    fi

# Clean up the vessel we used to transport this data.
RUN rm -rf files && rm -f {{{app.name}}}/{{{app.name}}}.tar.gz
