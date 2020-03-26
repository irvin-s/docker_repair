# Set the base image to beakerx
FROM lobnek/jupyter:v2.8 as builder

# File Author / Maintainer
MAINTAINER Thomas Schmelzer "thomas.schmelzer@lobnek.com"

# install the pyaddepar package
COPY --chown=beakerx:beakerx . /home/beakerx/tmp

# install the package
RUN pip install --no-cache-dir /home/beakerx/tmp && \
    rm -r /home/beakerx/tmp

WORKDIR ${WORK}

########################################################################################################################
FROM builder as test

WORKDIR ${WORK}

#COPY --chown=beakerx:beakerx test ${WORK}/test

# this is used to mock http for testing
RUN pip install httpretty pytest==4.3.1 pytest-cov pytest-html sphinx requests-mock
CMD py.test --cov=pyaddepar  --cov-report html:artifacts/html-coverage --cov-report term --html=artifacts/html-report/report.html ${WORK}/test
