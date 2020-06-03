#
# This is the docker image used for ./bin/run-tests.sh and development tasks.
#
# It will NOT reresolve all dependencies on every change (as opposed to Dockerfile)
# but it ultimately results in a larger docker image.
#
FROM marathon-build

RUN git reset --hard HEAD && \
    git checkout master && \
    git pull

RUN sbt -Dsbt.log.format=false assembly && \
        mv $(find target -name 'marathon-assembly-*.jar' | sort | tail -1) ./ && \
        rm -rf target/* && \
        mv marathon-assembly-*.jar target
