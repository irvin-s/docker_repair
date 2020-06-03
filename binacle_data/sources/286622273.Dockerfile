FROM lambci/lambda:build-nodejs8.10

WORKDIR /user

RUN yum install git vi -y

# set home folder
ENV HOME /user

RUN touch ~/.bashrc && \
  curl -o- -L https://yarnpkg.com/install.sh | bash && \
  source ~/.bashrc && \
  yarn global add serverless@1.35.0

RUN touch ~/.bash_aliases && \
  echo '# yarn-upgrade' >> ~/.bashrc && \
  echo "alias yu='yarn upgrade --latest --force'" >> ~/.bashrc && \
  echo '# yarn re-install' >> ~/.bashrc && \
  echo "alias yi='yarn install --offline --frozen-lockfile'" >> ~/.bashrc && \
  echo '# run tests' >> ~/.bashrc && \
  echo "alias t='yarn test'" >> ~/.bashrc && \
  echo "alias ts='yarn run test-simple'" >> ~/.bashrc && \
  source ~/.bash_aliases

RUN chmod -R 757 /user

# set correct execution env
ENV LAMBDA_TASK_ROOT /user/project
# disable babel trying to access root file location
ENV BABEL_DISABLE_CACHE 1

ENTRYPOINT (cd project && bash)
