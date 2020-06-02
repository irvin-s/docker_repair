#
# This is the docker image used for ./bin/run-tests.sh and development tasks.
#
# It will NOT reresolve all dependencies on every change (as opposed to Dockerfile)
# but it ultimately results in a larger docker image.
#
FROM marathon-base
RUN sbt compile
