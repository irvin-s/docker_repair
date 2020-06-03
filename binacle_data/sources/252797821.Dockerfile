FROM cocoon/base  
MAINTAINER cocoon  
  
  
# install some python libs  
ADD docker/requirements.txt /tmp/  
RUN pip install -r /tmp/requirements.txt  
  
#  
# Install pjsua binary dist  
# get pjsua  
ADD docker/pjsua-2.1.0.linux-x86_64 /tmp/pjsua-2.1.0.linux-x86_64  
  
# copy pjsua to pyrun lib  
RUN cp /tmp/pjsua-2.1.0.linux-x86_64/* /usr/local/lib/python2.7/dist-packages/  
  
#  
# Install Syprunner  
#  
ADD . /tmp/syprunner/  
WORKDIR /tmp/syprunner  
RUN python setup.py install  
  
RUN rm -rf /tmp/syprunner  
  
#  
# install some tests and media  
#  
RUN mkdir /tests  
WORKDIR /tests  
  
ADD docker/tests /tests  
  
ADD player/play_rfpilot.py /tests/python/  
ADD player/play_rf_pilot.sh /tests/python/  
ADD player/platform.json /tests/python/  
ADD player/play_sypterm.py /tests/python/  

