FROM ubuntu:14.04

# install node.js and npm
RUN apt-get -qq update && apt-get install -y \
  nodejs \
  npm \
  git \
  curl

#May want to switch to python dredd hooks, so install
RUN apt-get update
RUN apt-get install -y python-pip
#We've submitted 2 pull requests, until those are merged, we'll pull our own code in
RUN pip install dredd_hooks
#RUN git clone https://github.com/apiaryio/dredd-hooks-python.git
#RUN cd /dredd-hooks-python && python setup.py install

#Symlink
RUN ln -s /usr/bin/nodejs /usr/bin/node

# install dredd version older
RUN npm install -g dredd@1.0.8

#install node modules
RUN npm install dredd@1.0.8

#Execute the node app
WORKDIR /home/dredd_scripts
CMD ["node","dds-dredd.js"]
