# Docker image for the Drone build runner
#
#     CGO_ENABLED=0 go build -a -tags netgo
#     docker build --rm=true -t rics3n/drone-ansible .

FROM williamyeh/ansible:alpine3

ADD drone-ansible /bin/

ENTRYPOINT ["/bin/drone-ansible"]