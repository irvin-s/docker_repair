FROM ruby:2-slim

LABEL "name"="Docker Tagging Action"
LABEL "maintainer"="GitHub Actions <support+actions@github.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.icon"="tag"
LABEL "com.github.actions.color"="blue"
LABEL "com.github.actions.name"="Docker Tag"
LABEL "com.github.actions.description"="This tags an image at $1 to $2, with tags based on the action environment"
COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

ENV DOCKERVERSION=18.06.1-ce

RUN apt-get update && \
    apt-get --no-install-recommends -y install \
        ca-certificates \
        curl && \
    curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKERVERSION}.tgz && \
    tar xzvf docker-${DOCKERVERSION}.tgz --strip 1 -C /usr/local/bin docker/docker && \
    rm docker-${DOCKERVERSION}.tgz && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./

RUN bundle install --without=test

COPY tag.rb /bin/tag

ENTRYPOINT ["tag"]
CMD ["help"]
