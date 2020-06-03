FROM cwds/intake_base_image

ENV APP_HOME /ca_intake
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ARG BUILD_DATE
ARG BUILD_NUMBER
ARG VERSION
ARG VCS_REF
LABEL application=intake_accelerator \
  gov.ca.cwds.build-date=${BUILD_DATE} \
  gov.ca.cwds.build-number=${BUILD_NUMBER} \
  gov.ca.cwds.version=${VERSION} \
  gov.ca.cwds.name=Intake \
  gov.ca.cwds.license=Apache-2.0 \
  gov.ca.cwds.vcs-ref=${VCS_REF} \
  gov.ca.cwds.vcs-type=git \
  gov.ca.cwds.vcs-url=git@github.com:ca-cwds/intake.git \
  gov.ca.cwds.vendor=Intake
COPY release /release
RUN dpkg -i /release/*.deb && rm -rf /release

ENV BUNDLE_PATH /ca_intake/ruby_gems

COPY scripts/release.sh /usr/local/bin/release.sh
RUN chmod +x /usr/local/bin/release.sh

VOLUME ["/ca_intake/public"]

ENTRYPOINT ["release.sh"]
