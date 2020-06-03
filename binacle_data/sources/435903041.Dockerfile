FROM hashicorp/terraform:0.11.13

LABEL version="1.0.0"
LABEL repository="http://github.com/innovationnorway/github-action-terraform"
LABEL homepage="http://github.com/innovationnorway/github-action-terraform"
LABEL maintainer="Innovation Norway Support <support+github@innovationnorway.com>"

LABEL "com.github.actions.name"="Terraform Test"
LABEL "com.github.actions.description"="Run terraform init, validate, apply, and then destroy."
LABEL "com.github.actions.icon"="box"
LABEL "com.github.actions.color"="purple"

COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
