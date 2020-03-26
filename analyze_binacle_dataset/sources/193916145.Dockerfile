# Use base
FROM coregistry:5000/cloudopting/ubuntubase
# Add puppet modules:
ADD modules /tmp/modules
# Add manifest to apply
ADD ./consumer.pp /tmp/manifest.pp
# Apply manifest
RUN puppet apply --modulepath=/tmp/modules /tmp/manifest.pp
