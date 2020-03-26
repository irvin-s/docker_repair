from krystism/openstack-keystone

COPY ./scripts/docker/keystone/keystone.sh /home/keystone.sh

ENV OS_TENANT_NAME admin
ENV OS_USERNAME admin
