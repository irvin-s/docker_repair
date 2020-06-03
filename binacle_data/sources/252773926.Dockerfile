FROM python:2  
LABEL maintainer="Oleksandr Kosse <okosse@mirantis.com>"  
  
RUN apt-get update -qq && \  
apt-get install -q -y \  
python-dev \  
libvirt-dev && \  
pip install pdbpp && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
WORKDIR /opt/  
  
RUN pip install xunit2testrail  
  
ENV PASTE_BASE_URL=""  
ENV TESTRAIL_PLAN_NAME="[MCP1.1]All-In-One"  
ENV SHORT_TEST_GROUP="All-In-One"  
ENV TESTRAIL_URL="https://mirantis.testrail.com"  
ENV TESTRAIL_USER='okosse@mirantis.com'  
ENV TESTRAIL_PROJECT='Mirantis Cloud Platform'  
ENV TESTRAIL_MILESTONE='MCP1.1'  
ENV TESTRAIL_SUITE='Tempest 15.0.0'  
ENV REPORT=/srv/report.xml  
  
COPY entrypoint.sh /opt/  
  
ENTRYPOINT ["/opt/entrypoint.sh"]  

