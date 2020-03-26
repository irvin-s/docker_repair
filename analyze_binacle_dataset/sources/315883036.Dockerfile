


USER root

ENV PYTHONPATH=${PYTHONPATH}:${ODOO_FRM}
ENV DODOO_LOAD_OUT=/var/lib/dodoo-loader/logs.json

# --- WDB Configuration ---
ENV WDB_NO_BROWSER_AUTO_OPEN=True \
    WDB_SOCKET_SERVER=wdb \
    WDB_WEB_PORT=1984 \
    WDB_WEB_SERVER=localhost


# Get dodoo-* devops toolchain
RUN pip install \
    # dodoo-scaffolder \
    # dodoo-translator \
    dodoo-tester \
    dodoo-initializer \
    dodoo-loader \
    dodoo-migrator


# Custom Odoo Scaffolding dependency
RUN pip  --quiet --quiet install pick


# General develpoment libraries
RUN pip --quiet --quiet install \
        astor \
        pylint-odoo \
        pylint-mccabe \
        coverage \
        ptpython \
        pudb \
        pyinotify \
        watchdog \
        wdb

# For querying json log output
RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends jq  > /dev/null


# local browser testing
RUN wget --quiet -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
    && apt-get -qq update && apt-get -qq install -y --no-install-recommends google-chrome-stable > /dev/null
# For js test recordings
# Not avaialble in jessie
RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends ffmpeg  > /dev/null || true
# For chrome bworser testing
RUN pip  --quiet --quiet install websocket-client



COPY entrypoint.d/* /entrypoint.d/
COPY templates /templates
ENV ODOO_TEMPLATES_DIR="/templates"

RUN /bin/bash -c 'shopt -s dotglob \
 && chmod +x /entrypoint.d/* \
 && shopt -u dotglob'


# Prepare odoo owned testlog folder for chrome screenshots
RUN mkdir -p /var/lib/odoo-testlogs && chown odoo:odoo /var/lib/odoo-testlogs


# Prepare odoo owned loading log folder for dodoo loader
RUN mkdir -p /var/lib/dodoo-loader && chown odoo:odoo /var/lib/dodoo-loader
