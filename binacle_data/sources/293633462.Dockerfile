# Can't build a new image with bazel 0.9
# see https://github.com/bazelbuild/bazel/issues/4947
# So just patch up a previously built container

FROM angular/ngcontainer:0.1.0

###
# This version of ChromeDriver works with the Chrome version included
# in the circleci/*-browsers base image above.
# This variable is intended to be used by passing it as an argument to
# "postinstall": "webdriver-manager update ..."
ENV CHROMEDRIVER_VERSION_ARG "--versions.chrome 2.33"
