FROM node:10

LABEL version="2.0.0"
LABEL repository="http://github.com/actions/npm"
LABEL homepage="http://github.com/actions/npm"
LABEL maintainer="GitHub Actions <support+actions@github.com>"

LABEL com.github.actions.name="GitHub Action for npm"
LABEL com.github.actions.description="Wraps the npm CLI to enable common npm commands."
LABEL com.github.actions.icon="package"
LABEL com.github.actions.color="red"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]
CMD ["help"]
