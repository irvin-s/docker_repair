#
# ------------------------------------------------------
#                       Dockerfile
# ------------------------------------------------------
# image:    ansible-sbt
# tag:      latest
# name:     ansibleshipyard/ansible-base-ubuntu
# version:  v0.2.0
# repo:     https://github.com/AnsibleShipyard/ansible-nginx
# how-to:   docker build --force-rm -t ansibleshipyard/ansible-nginx .
# requires: ansibleshipyard/ansible-base-ubuntu
# authors:  github:@jasongiedymin,
#           github:
# ------------------------------------------------------

FROM ansibleshipyard/ansible-base-ubuntu
MAINTAINER ansibleshipyard

# -----> Env
ENV WORKDIR /tmp/build/roles/ansible-nginx
ENV NGINX_PREFIX /usr/local/nginx

WORKDIR /tmp/build/roles/ansible-nginx

# -----> Add assets
ADD ./meta $WORKDIR/meta
ADD ./tasks $WORKDIR/tasks
ADD ./vars $WORKDIR/vars
ADD ./templates $WORKDIR/templates
ADD ./handlers $WORKDIR/handlers
ADD ./ci $WORKDIR/ci

# -----> Install Galaxy Dependencies

# -----> Execute
RUN ansible-playbook -i $WORKDIR/ci/inventory $WORKDIR/ci/playbook.yml -c local -vvvv

EXPOSE 80

# Safely assume that since we FROM'd the base ubuntu
# that the nginx bin is in the default location
CMD ["bash", "/usr/local/nginx/nginx-start.sh"]
