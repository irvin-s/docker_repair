FROM node:10-jessie

LABEL com.github.actions.name="Next.js PR Performance Stats"
LABEL com.github.actions.description="Compares performance of a PR branch with the latest canary branch"
LABEL repository="https://github.com/zeit/next-stats-action"

# Make sure workdir is available for testing
# RUN mkdir -p /github/workspace

COPY ./test-project /test-project 
COPY ./get-stats /get-stats

# Install node_modules
RUN cd /get-stats && yarn install --production
RUN cd /test-project && yarn install --production

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
