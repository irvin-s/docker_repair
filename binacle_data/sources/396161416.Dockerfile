# Base image
FROM fedora:latest
# ENV Variables
ENV APP=seed
ENV HOME=/home/app
ENV TERM=xterm
ENV NPM_CONFIG_PREFIX=$HOME/.npm-global
ENV PATH="$PATH:/home/app/$APP/node_modules/.bin:/home/app/.npm-global/bin"
# Create non-root user
RUN useradd --user-group --create-home --shell /bin/false app
# Core needed packages
RUN dnf -y groupinstall "Development Tools"
RUN dnf -y groupinstall "Development Libraries"
RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
RUN dnf -y install nodejs npm gcc-c++ which yarn
# NodeJS, Yarn & NPM setup
RUN cd $HOME && mkdir .npm-global
RUN npm -g install n
RUN n lts
RUN npm -g install npm
# Install global node dependencies
RUN npm -g install browser-refresh
# Bootstrap app
COPY package.json $HOME/$APP/
COPY yarn.lock $HOME/$APP/
COPY src/public/vendor/package.json $HOME/$APP/src/public/vendor/
COPY src/public/vendor/yarn.lock $HOME/$APP/src/public/vendor/
COPY src/ $HOME/$APP/
# Install local node dependencies
WORKDIR $HOME/$APP/
RUN yarn install
# Install local node dependencies
WORKDIR $HOME/$APP/src/public/vendor/
RUN yarn install --modules-folder=lib/
WORKDIR $HOME/$APP/
# Copy app to container
COPY . $HOME/$APP/
# Expose ports
EXPOSE  8000
# CMD
CMD ["yarn", "start"]
