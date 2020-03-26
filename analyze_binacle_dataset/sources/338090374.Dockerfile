# Sample invocation:
#   From the directory of the Dockerfile-2.0
#   docker build -f Dockerfile-2.0 --build-arg version=2.0 -t ibmcase/icp-cloudant-backup .
#
FROM alpine
ARG version

# bash is needed for the various scripting idioms used in the shell scripts
# Experiments showed that the Alpine default shell (Almquist shell) is not sufficient.
# Curl is needed for interaction with Cloudant REST API.
# Nodejs is needed for Cloudant backup/restore utilities.
# The jq utility is used to parse the JSON that is returned from cloudantdb REST calls.
# couchbackup has the couchbackup and couchrestore utilities.
# couchdb-cli is used for creating and deleting databases.
#
RUN apk add --update bash curl nodejs jq
RUN npm install -g @cloudant/couchbackup
RUN npm install -g couchdb-cli

# Kubectl is needed to get information from cloudantdb service and from cloudant-credentials secret
RUN curl --silent -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# If the +x bit is on in the source then it will be retained in the image.
COPY $version/*.sh /

CMD [ "/cloudant-backup.sh", "--dbhost", "cloudantdb.kube-system", \
      "--backup-home", "/data/backups", \
      "--exclude", "metrics metrics_app" ]
