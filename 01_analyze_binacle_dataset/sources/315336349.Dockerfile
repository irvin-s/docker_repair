FROM rocker/r-ver:3.5.0

LABEL maintainer="Scott Came (scottcame10@gmail.com)" \
  org.label-schema.description="Image with shiny-server 1.5.7.907 and R 3.5.0 that supports SAML assertions in session" \
  org.label-schema.vcs-url="https://github.com/scottcame/shiny-microservice-demo/docker/shiny" \
  license="AGPLv3"

# Underlying Shiny Server software is licensed under the GNU Affero Public License.
# See https://github.com/rstudio/shiny-server/blob/master/COPYING for details.

#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU Affero General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU Affero General Public License for more details.
#
#     You should have received a copy of the GNU Affero General Public License
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.

# We need to build to a specific version of shiny-server, since we will be editing some of the node js files
# This also gives us the opportunity to include some additional libraries/packages that we need

RUN apt-get update && \
  apt-get install -y net-tools libssl-dev libxml2-dev gdebi-core pandoc pandoc-citeproc libcurl4-gnutls-dev libcairo2-dev libxt-dev curl libmariadbclient-dev && \
  cd /tmp && \
  curl -O https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.7.907-amd64.deb && \
  R -e 'install.packages(c("xml2", "lubridate", "tidyverse", "shiny", "rmarkdown", "RMariaDB"), repos="https://cran.rstudio.com/")' && \
  gdebi -n shiny-server-1.5.7.907-amd64.deb && \
  rm shiny-server-1.5.7.907-amd64.deb && rm -rf /var/lib/apt/lists/*

COPY files/shiny-server.conf /etc/shiny-server/

# Here we apply edits to pass around whitelisted headers defined in files/header-whitelist.js
# With some effort, this could be refactored to support a config parameter, but this is the minimal thing needed to meet the objectives of the demo
# These edits were based upon those in this PR: https://github.com/rstudio/shiny-server/pull/257

RUN sed -i \
  -e "17c\    exitPromise, kill, headers) {" \
  -e "25i\  this.headers=headers;" \
  /opt/shiny-server/lib/worker/app-worker-handle.js

RUN sed -i \
  -e "23ivar whitelistedHeaders = require('../header-whitelist').headerWhitelist;" \
  -e "121i\    var headers = _.pick(conn.headers, whitelistedHeaders);" \
  -e "129c\      wrk = schedulerRegistry.getWorker(appSpec, 'ws', null, headers);" \
  -e "167c\      wsClient = appWorkerHandle.endpoint.createWebSocketClient(pathInfo, headers);" \
  /opt/shiny-server/lib/proxy/sockjs.js

RUN sed -i \
  -e "25ivar whitelistedHeaders = require('../header-whitelist').headerWhitelist;" \
  -e "138i\      var headers = _.pick(req.headers, whitelistedHeaders);" \
  -e "144c\        wrk = schedulerRegistry.getWorker(appSpec, pathname, worker, headers);" \
  /opt/shiny-server/lib/proxy/http.js

RUN sed -i \
  -e "66c\  this.getWorker = function(appSpec, url, worker, headers) {" \
  -e "77c\    return this.\$schedulers[key].acquireWorker(appSpec, url, worker, headers);" \
  /opt/shiny-server/lib/scheduler/scheduler-registry.js

RUN sed -i \
  -e "226c\          _.bind(appWorker.kill, appWorker, workerData.headers));" \
  /opt/shiny-server/lib/scheduler/scheduler.js

RUN sed -i \
  -e "34c\        this.acquireWorker = function(appSpec, url, worker, headers) {" \
  -e "71c\            return this.spawnWorker(appSpec, {headers: headers});" \
  /opt/shiny-server/lib/scheduler/simple-scheduler.js

COPY files/header-whitelist.js /opt/shiny-server/lib/

# We also need to modify the hardcoded list of passed-thru headers in sockjs, to add the one that Shibboleth SP adds to each request containing
#  the address at which the user's assertion is available

RUN sed -i '169i     ref.push("shib-assertion-01");' /opt/shiny-server/node_modules/sockjs/lib/transport.js

# uncomment if you want all the shiny examples available
# RUN cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-server/

RUN mkdir -p /srv/shiny-server/hostinfo
RUN mkdir -p /srv/shiny-server/saml

COPY files/hostinfo/app.R /srv/shiny-server/hostinfo/
COPY files/saml/app.R /srv/shiny-server/saml/
COPY files/db-access/app.R /srv/shiny-server/db-access/
COPY files/db-access-secure/app.R /srv/shiny-server/db-access-secure/

RUN mkdir -p /var/log/shiny-server

# If docker exec-ing into a running container, 99 times out of 100 you want to be in the app logs directory, so here you go...
WORKDIR /var/log/shiny-server

CMD ["/opt/shiny-server/bin/shiny-server"]
