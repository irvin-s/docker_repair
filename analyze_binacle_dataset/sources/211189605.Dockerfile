# syntax=docker/dockerfile:1.0.0-experimental
FROM alpine:3.8

RUN apk add --no-cache openssh-client git

# download public server key for github.com server
# to avoid prompts
RUN mkdir -p -m 0700 ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts

# clone a private repo to prove we can auth
RUN --mount=type=ssh git clone \
    git@github.com:hairyhenderson/private-repo.git

# uncomment to fail fast when no agent is forwarded
# RUN --mount=type=ssh,required git clone \
#     git@github.com:hairyhenderson/private-repo.git

# make sure we cloned the repo
RUN cd private-repo && grep "private-repo" README.md
