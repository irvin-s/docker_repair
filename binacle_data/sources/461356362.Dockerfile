# A Dockerfile to package playbooks as a docker image
#
# This example includes additional steps during the image build process
# to add external dependencies: Python modules and the "oc" client binary
#
# If you only need to package simple self-contained playbooks without
# external dependencies take a look at Dockerfile.simple
#
# If using OpenShift, consider using the platform's source2image build instead

FROM docker.io/aweiteka/playbook2image:latest

# There are two approaches to customize the built image and include
# additional requirements/dependencies: use the built-in "assemble" script
# or a fully custom build

# -------------------------------------------------------------------------
# Option 1: using "assemble"
#
# The playbook2image's "assemble" script provides functionality to install
# dependencies.
#
# This example will install the "oc" client binary and the Python modules
# specified in the "requirements.txt" from YOUR_PLAYBOOK's top dir.
#
# The "assemble" script expects the playbooks to be placed in /tmp/src:
ADD YOUR_PLAYBOOK /tmp/src

ENV INSTALL_OC=true

# If you don't have a "requirements.txt", or if you want to overrideit, you
# can also specify Python dependencies via the "PYTHON_REQUIREMENTS"
# environment variable with the list of required modules:
#ENV PYTHON_REQUIREMENTS="PyYAML pyOpenSSL"

RUN /usr/libexec/s2i/assemble

# -------------------------------------------------------------------------
# Option 2: custom build
#
# Here, instead of placing the plabyooks in /tmp/src and settings to run
# the "assemble" script we put the playbooks directly into their final
# location and run commands to install extra dependencies:
#
#ADD YOUR_PLAYBOOK ${APP_HOME}
#ADD your_dynamic_inventory_script.py requirements.txt ${APP_HOME}
#RUN pip install -r ${APP_HOME}/requirements.txt

# -------------------------------------------------------------------------
# In any case, containers from the built image should invoke the default
# "run" script provided by the base image
CMD ["/usr/libexec/s2i/run"]
