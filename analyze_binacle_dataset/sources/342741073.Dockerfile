FROM ubuntu:18.04

COPY binaries/check           /opt/resource/check
COPY binaries/in              /opt/resource/in

COPY binaries/build-pass-fail /opt/tasks/build-pass-fail

COPY binaries/show-build      /opt/tasks/show-build
COPY binaries/show-plan       /opt/tasks/show-plan
COPY binaries/show-resources  /opt/tasks/show-resources
COPY binaries/show-job        /opt/tasks/show-job
COPY binaries/show-logs       /opt/tasks/show-logs
