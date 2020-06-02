# Mozilla AutoPush Load-Tester  
FROM pypy:2-5.10.0-slim  
  
MAINTAINER Ben Bangert <bbangert@mozilla.com>  
  
RUN mkdir -p /home/ap-loadtester  
ADD . /home/ap-loadtester/  
  
WORKDIR /home/ap-loadtester  
  
RUN \  
BUILD_DEPS="git build-essential" && \  
# wget not required but nice to have  
RUN_DEPS="wget libssl-dev" && \  
apt-get update && \  
apt-get install -yq --no-install-recommends ${BUILD_DEPS} ${RUN_DEPS} && \  
pip install virtualenv && \  
virtualenv -p `which pypy` apenv && \  
./apenv/bin/pip install pyasn1 && \  
./apenv/bin/pip install -r requirements.txt -e . && \  
apt-get purge -yq --auto-remove ${BUILD_DEPS} && \  
apt-get autoremove -qq && \  
apt-get clean -y  
# End run  
  
CMD ["./apenv/bin/aplt_testplan"]  

