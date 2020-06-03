FROM logstash:2.3.1

# 
# Build arguments not passed to container
# 
# TEST_SUITE_DIR                    path relative to Dockerfile
# PATTERN_TARGET_DIR                full path to place grok patterns in docker image

ARG TEST_SUITE_DIR=example
ARG EXTRA_PLUGINS="logstash-filter-translate logstash-input-http"
ARG PATTERN_TARGET_DIR=/etc/logstash/patterns

# 
# Environment variables passed into running container
# 
# TEST_FILTER_SUBSET                path relative to TEST_SUITE_DIR/test/filters or leave empty
# RUN_CONFIGTEST                    'true' or 'false'
# TEST_TARGET                       'all', 'patterns', or 'filters'
# FILTER_FILENAME_REGEX             regular expression to identify filter configuration files

ENV TEST_FILTER_SUBSET= \ 
    RUN_CONFIGTEST=true \ 
    TEST_TARGET=all \
    PATTERN_TARGET_DIR=${PATTERN_TARGET_DIR} \
    FILTER_FILE_REGEX=*.filter.conf \
    EXTRA_PLUGINS=${EXTRA_PLUGINS}

RUN logstash-plugin install --development
RUN logstash-plugin install ${EXTRA_PLUGINS}

ADD test /test
# ADD $TEST_SUITE_DIR/config/conf.d /test/spec/filter_config
# ADD $TEST_SUITE_DIR/config/patterns $PATTERN_TARGET_DIR
ADD $TEST_SUITE_DIR/test/filters /test/spec/filter_data
ADD $TEST_SUITE_DIR/test/patterns /test/spec/pattern_data

ENTRYPOINT ["/test/run-tests.sh"]
# ENTRYPOINT ["bash"]
