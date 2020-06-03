FROM gcr.io/cloud-builders/kubectl

LABEL version="1.0.0"
LABEL name="aws-kubectl"
LABEL repository="http://github.com/actions/aws"
LABEL homepage="http://github.com/actions/aws"

LABEL maintainer="GitHub Actions <support+actions@github.com>"
LABEL com.github.actions.name="GitHub Action for AWS - kubectl"
LABEL com.github.actions.description="Stores a kubectl config"
LABEL com.github.actions.icon="box"
LABEL com.github.actions.color="yellow"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

RUN apt-get update -y && \
    apt-get install -y curl gnupg && \
    curl -Lso /bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.11.5/2018-12-06/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /bin/aws-iam-authenticator && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
