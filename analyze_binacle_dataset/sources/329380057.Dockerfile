FROM quay.io/leetrout/notebook-server

# Accessing HTTPS webpages requires crypography libraries
RUN apk add openssl openssl-dev libffi-dev

# Parsing HTML / XML requires the libxml library
# along with the headers so we install the lib and the dev headers
RUN apk add libxml2 libxml2-dev xmlsec xmlsec-dev

RUN mkdir -p /data/class-03

RUN adduser -D unc

RUN chown -R unc /data

WORKDIR /data/class-03

USER unc

COPY requirements.txt .

# Must be root to install to the main python libs location
USER root

# Using Python 3 so we explicitly use pip3
RUN pip3 install -r requirements.txt

COPY "Cleaning_Wikipedia_1.ipynb" .
COPY "Scrape_Heels_Baseball.ipynb" .
COPY "nobel_winners_dirty.json" .

USER unc

ENTRYPOINT /usr/bin/jupyter-notebook --notebook-dir=/data/class-03 --NotebookApp.token="" --ip=0.0.0.0 --port=9000
