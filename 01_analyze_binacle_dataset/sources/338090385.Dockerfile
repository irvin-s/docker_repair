# Sample invocation:
#   From the directory of the Dockerfile-#.#
#   docker build -f Dockerfile-1.0 --build-arg version=1.0 -t ibmcase/icp-mariadb-backup .
#
FROM alpine
ARG version

# bash is needed for the various scripting idioms used in the shell scripts
# Experiments showed that the Alpine default shell (Almquist shell) is not sufficient.
# curl is needed to install kubectl
# The jq utility is used to parse the JSON that is returned from kubectl commands.
#
#
RUN apk add --update bash curl jq mysql-client

# Kubectl is needed to get information from mariadb service and from platform-mariadb-credentials secret
RUN curl --silent -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# If the +x bit is on in the source then it will be retained in the image.
COPY $version/*.sh /

CMD [ "/get-database-names.sh", "--dbhost", "mariadb.kube-system" \
    ]
