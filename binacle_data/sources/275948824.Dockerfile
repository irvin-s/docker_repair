FROM ljfranklin/terraform-resource:0.10.8

RUN mkdir -p .terraform.d/plugins
COPY oci-provider/linux_amd64/ .terraform.d/plugins/linux_amd64/
COPY null-provider/linux_amd64/ .terraform.d/plugins/linux_amd64/
