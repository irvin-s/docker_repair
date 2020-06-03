FROM java:8

ENV SYNTAXNETDIR=/opt/tensorflow PATH=$PATH:/root/bin

RUN mkdir -p $SYNTAXNETDIR
RUN  cd $SYNTAXNETDIR
RUN  apt-get update
RUN  apt-get install git zlib1g-dev file swig python2.7 python-dev python-pip python-mock -y
RUN  pip install --upgrade pip
RUN  pip install -U protobuf==3.0.0b2
RUN  pip install asciitree
RUN  pip install numpy
RUN  wget https://github.com/bazelbuild/bazel/releases/download/0.4.3/bazel-0.4.3-installer-linux-x86_64.sh
RUN  chmod +x bazel-0.4.3-installer-linux-x86_64.sh
RUN  ./bazel-0.4.3-installer-linux-x86_64.sh --user
RUN  git clone --recursive https://github.com/tensorflow/models.git

#SH the git clone above did not succeed for some reason. Re-ran the git clone command and the 
# following from within docker, and then committed image before exiting using 
#	docker commit <containerid> tensorflow:works
#SH NOTE - needs a lot of RAM to run the tests. Currently allocated 8 Gig (works). 2G causes
# tests to abort prematurely, and then syntaxnet won't run as the tests compile it

#RUN  cd $SYNTAXNETDIR/models/syntaxnet/tensorflow
#RUN  echo -e "\n\n\n\n\n\n\n\n\n" | ./configure
#RUN  apt-get autoremove -y
#RUN  apt-get clean

#RUN cd $SYNTAXNETDIR/models/syntaxnet
#RUN  bazel test --genrule_strategy=standalone syntaxnet/... util/utf8/...

#WORKDIR $SYNTAXNETDIR/models/syntaxnet

#CMD [ "sh", "-c", "echo 'Bob brought the pizza to Alice.' | syntaxnet/demo.sh" ]