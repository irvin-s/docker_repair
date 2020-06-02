# Use base
FROM cloudopting/ubuntubase:14.04

RUN apt-get -yqq update && apt-get -yqq install git python python-pip python-dev && apt-get clean && rm -rf /var/lib/apt /var/cache/apt/archives/* /tmp/* /var/tmp/*

# Add puppet modules:
ADD ./modules /tmp/modules
# Add manifest to apply
ADD ./manifest.pp /tmp/manifest.pp
# Apply manifest
RUN puppet apply --modulepath=/tmp/modules /tmp/manifest.pp
