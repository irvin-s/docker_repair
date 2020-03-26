FROM node:alpine
# install webpack related development components
RUN npm install --save-dev \
    webpack style-loader css-loader less-loader file-loader less \
    babel-core babel-preset-es2015 babel-preset-stage-0 babel-loader \
    babel-preset-react
# install vendor components
RUN npm install --save \
    medium-editor rangy \
    react react-dom \
    react-tooltip \
    font-awesome font-awesome-webpack

# for our convenience
RUN echo 'PATH=$PATH:/node_modules/.bin' > /etc/profile
ENV ENV=/etc/profile

# create the build command #eQUke#
RUN echo '/node_modules/.bin/webpack --config /src/webpack.config.js --watch --watch-poll' > build.sh
RUN chmod +x build.sh

# by default, run this build command
CMD sh build.sh
