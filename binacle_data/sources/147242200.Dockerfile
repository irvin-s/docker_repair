#
# Dockerfile generated from https://github.com/cloudposse/reference-architectures
#

FROM ${geodesic_base_image}

ENV DOCKER_IMAGE="${docker_registry}/${image_name}"
ENV DOCKER_TAG="${image_tag}"

# General
ENV NAMESPACE="${namespace}"
ENV STAGE="${stage}"

# Geodesic banner
ENV BANNER="${stage}"

# Message of the Day
ENV MOTD_URL="${motd_url}"

# AWS Region
ENV AWS_REGION="${aws_region}"
ENV AWS_ACCOUNT_ID="${aws_account_id}"
ENV AWS_ROOT_ACCOUNT_ID="${aws_root_account_id}"

# Network CIDR Ranges
ENV ORG_NETWORK_CIDR="${org_network_cidr}"
ENV ACCOUNT_NETWORK_CIDR="${account_network_cidr}"

# chamber KMS config
ENV CHAMBER_KMS_KEY_ALIAS="alias/$${NAMESPACE}-$${STAGE}-chamber"

# Terraform State Bucket
ENV TF_BUCKET_PREFIX_FORMAT="basename-pwd"
ENV TF_BUCKET_ENCRYPT="true"
ENV TF_BUCKET_REGION="$${AWS_REGION}"
ENV TF_BUCKET="$${NAMESPACE}-$${STAGE}-terraform-state"
ENV TF_DYNAMODB_TABLE="$${NAMESPACE}-$${STAGE}-terraform-state-lock"

# Default AWS Profile name
ENV AWS_DEFAULT_PROFILE="$${NAMESPACE}-$${STAGE}-admin"
ENV AWS_MFA_PROFILE="$${NAMESPACE}-root-admin"

# Place configuration in 'conf/' directory
COPY conf/ /conf/

# Filesystem entry for tfstate
RUN s3 fstab '$${TF_BUCKET}' '/' '/secrets/tf'

COPY rootfs/ /

WORKDIR /conf/
