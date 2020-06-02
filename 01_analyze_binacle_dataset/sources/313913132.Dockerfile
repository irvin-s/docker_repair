ARG BASE_IMAGE
FROM ${BASE_IMAGE}


WORKDIR /root

ARG SYSTEM_PACKAGES_FILE=system-packages.txt
COPY ${SYSTEM_PACKAGES_FILE} .

RUN packages=$(cat ${SYSTEM_PACKAGES_FILE} | sed 's/ /-/' | uniq | paste -d' ' -); \
    if [ -n "${packages}" ]; then tdnf install -y ${packages}; fi


WORKDIR ${WORKDIR}

ARG PACKAGES_FILE=packages.txt
COPY ${PACKAGES_FILE} deps.edn

RUN pj=$(cat deps.edn); if [ -n "${pj}" ]; then clojure -Stree; else echo '{}' > deps.edn; fi
