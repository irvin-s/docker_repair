# An simple Dockerfile example to package playbooks as docker image
#
# If using OpenShift, consider using the platform's source2image build instead.
# If your playbooks have dependencies that must be packaged into the image at
# build time see the Dockerfile.advanced example

FROM docker.io/aweiteka/playbook2image:latest

# Add your playbook and associated roles, filters, etc
ADD YOUR_PLAYBOOK ${APP_HOME}

# Containers from the built image should invoke the default "run" script
# provided by the base image
CMD ["/usr/libexec/s2i/run"]
