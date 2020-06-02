# This Dockerfile will build an image that is configured to use Fluentd to
# collect container log files from the specified paths and send them to the
# Google Cloud Logging API with configurable format based on FILES_FORMAT

# The environment variable that controls which log files are collected is
# FILES_TO_COLLECT. Files specified in the environment variable should be
# separated by whitespace, as in "/var/log/syslog /var/log/nginx/access.log".
# This configuration assumes that the host performing the collection is a VM
# that has been created with a logging.write scope and that the Logging API
# has been enabled for the project in the Google Developer Console.

FROM gcr.io/google_containers/fluentd-sidecar-gcp:1.4
MAINTAINER Randy Fay "rfay@newmediadenver.com"

# Copy the configuration file generator for creating input configurations for
# each file specified in the FILES_TO_COLLECT environment variable.
COPY config_generator.sh /usr/local/sbin/config_generator.sh

# Run the config generator to get the config files in place and start Fluentd.
# We have to run the config generator at runtime rather than now so that it can
# incorporate the files provided in the environment variable in its config.
CMD /usr/local/sbin/config_generator.sh && /usr/sbin/google-fluentd -qq --use-v1-config --suppress-repeated-stacktrace > /var/log/google-fluentd/google-fluentd.log
