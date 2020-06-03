FROM consol/centos-xfce-vnc:latest

MAINTAINER Wang Cheng (Ken) "463407426@qq.com"
ENV REFRESHED_AT 2018-06-19

# Set proxy if necessary
# ENV http_proxy 127.0.0.1:3128
# ENV https_proxy 127.0.0.1:3128

# Chrome: You could get the previous chrome here: http://orion.lcg.ufrj.br/RPMS/myrpms/google/
# Chromium: Every time you install backstopjs, the latest chromium is installed, and this will cause the mismatch error during the test.
# Here, we set the chromium to a constant one: 68.0.3419.0
ARG CHROME=66.0.3359.181-1
ARG CHROMIUM_VERSION=68.0.3419.0
# Gemini - Firefox 47.0.2 for test: https://github.com/gemini-testing/gemini/issues/688
# BackstopJS - Firefox: No matter using Slimer 0.10.3 or 1.0.0, the backstopjs has a bug here: https://github.com/garris/BackstopJS/issues/311
# You could get previous firefox here: https://ftp.mozilla.org/pub/firefox/releases/
ARG FIREFOX=47.0.2
ARG GECKO_VERSION=0.13.0
ARG PHANTOMJS_VERSION=2.1.1
ARG CHROMEDRIV_VERSION=2.38
ARG CASPERJS_VERSION=1.1.4
ARG SLIMERJS_VERSION=1.0.0
ARG BACKSTOPJS_VERSION=3.2.17
ARG GEMINI_VERSION=5.7.2
ARG GEMINIGUI_VERSION=6.0.1
ARG GEMINIHTMLREPORTER_VERSION=2.18.1
ARG SELENIUMSTANDALONE_VERSION=6.12.0
ARG NODEJS_VERSION=8.x
ARG NPM_VERSION=5.6.0
ARG USER=ta-visual-lib
# Use 2.53.1 to support firefox for Gemini: https://github.com/gemini-testing/gemini/issues/643#issuecomment-278339739
ARG SELENIUM_SERVER_VERSION=2.53.1

# Switch back to root user for extend the consol/centos-xfce-vnc:latest
# For more info, please refer to https://github.com/ConSol/docker-headless-vnc-container
USER 0

# Create Work Dir
WORKDIR /TA-Visual-Lib

# Copy
ADD src/. /TA-Visual-Lib/
ADD default-config.js /TA-Visual-Lib/

# Commbine all the RUN into one to decrease the image size
# The following RUN has the 4 main tasks
# 1. Remove the uncessary packages
# 2. Install Zip, Java, PhantomJS, Firefox, Chrome, NPM, NodeJS, CasperJS, SlimerJS, BackstopJS, Gemini
# 3. Create User with sudo access
# 4. Clear Cache
RUN chmod +x *.sh \
    && ./remove.sh \
    && ./tools.sh \
    && ./phantomjs.sh "${PHANTOMJS_VERSION}" \
    && ./firefox.sh "${FIREFOX}" "${GECKO_VERSION}" \
    && ./chrome.sh "${CHROME}" "${CHROMEDRIV_VERSION}" \
    && ./npm.sh "${NODEJS_VERSION}" "${NPM_VERSION}" \
    && ./visual.sh "${CASPERJS_VERSION}" "${SLIMERJS_VERSION}" "${BACKSTOPJS_VERSION}" "${CHROMIUM_VERSION}" "${GEMINI_VERSION}" "${SELENIUMSTANDALONE_VERSION}" "${GEMINIGUI_VERSION}" "${GEMINIHTMLREPORTER_VERSION}" "${SELENIUM_SERVER_VERSION}" \
    && ./user.sh "${USER}" \
    && ./clear.sh

# Change user from root -> ${user}
USER ${USER}
