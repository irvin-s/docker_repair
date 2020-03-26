FROM hashicorp/terraform:0.12.2

LABEL version="1.0.0"
LABEL repository="http://github.com/innovationnorway/github-action-terraform"
LABEL homepage="http://github.com/innovationnorway/github-action-terraform"
LABEL maintainer="Innovation Norway Support <support+github@innovationnorway.com>"

LABEL "com.github.actions.name"="GitHub Action for Terraform"
LABEL "com.github.actions.description"="Wraps the Terraform CLI to enable common Terraform commands."
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="purple"

COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
