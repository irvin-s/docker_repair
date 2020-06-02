FROM concourse/buildroot:curl

ADD assets/ /opt/resource/
ADD test/ /opt/resource-tests/
ADD tools/ /opt/tools/

RUN rm /usr/bin/jq
RUN mv /opt/tools/jq /usr/bin/jq

# Run tests
# RUN /opt/resource-tests/test-check.sh
# RUN /opt/resource-tests/test-in.sh
# RUN /opt/resource-tests/test-out.sh
