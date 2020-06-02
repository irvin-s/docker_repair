# debian:9.6 - linux; amd64
# https://github.com/docker-library/repo-info/blob/master/repos/debian/tag-details.md#debian96---linux-amd64
FROM debian@sha256:38236c068c393272ad02db100e09cac36a5465149e2924a035ee60d6c60c38fe

ARG BUILD_DATE
ARG CODENAME="stretch"
ARG CONDA_DIR="/opt/conda"
ARG CONDA_ENV_YML="data-toolkit-root-conda-base-env.yml"
ARG CONDA_INSTALLER="Miniconda3-4.5.4-Linux-x86_64.sh"
ARG CONDA_MD5="a946ea1d0c4a642ddf0c3a26a18bb16d"
ARG CONDA_URL="https://repo.continuum.io/miniconda"
ARG DCOS_CLI_URL="https://downloads.dcos.io/binaries/cli/linux/x86-64"
ARG DCOS_CLI_VERSION="1.12"
ARG DCOS_COMMONS_URL="https://downloads.mesosphere.com/dcos-commons"
ARG DCOS_COMMONS_VERSION="0.54.3"
ARG DEBCONF_NONINTERACTIVE_SEEN="true"
ARG DEBIAN_FRONTEND="noninteractive"
ARG DEBIAN_REPO="http://cdn-fastly.deb.debian.org"
ARG DISTRO="debian"
ARG GPG_KEYSERVER="hkps://zimmermann.mayfirst.org"
ARG HADOOP_HDFS_HOME="/opt/hadoop"
ARG HADOOP_MAJOR_VERSION="2.9"
ARG HADOOP_SHA256="3d2023c46b1156c1b102461ad08cbc17c8cc53004eae95dab40a1f659839f28a"
ARG HADOOP_URL="http://www-us.apache.org/dist/hadoop/common"
ARG HADOOP_VERSION="2.9.2"
ARG HOME="/root"
ARG JAVA_HOME="/opt/jdk"
ARG JAVA_URL="https://downloads.mesosphere.com/java"
ARG JAVA_VERSION="8u192"
ARG LANG="en_US.UTF-8"
ARG LANGUAGE="en_US.UTF-8"
ARG LC_ALL="en_US.UTF-8"
ARG LIBMESOS_BUNDLE_SHA256="217c43e4b642c1abdfe0fe309bbaede878cbc9a925562678b1c44273d140d40a"
ARG LIBMESOS_BUNDLE_URL="https://downloads.mesosphere.com/libmesos-bundle"
ARG LIBMESOS_BUNDLE_VERSION="1.12.0"
ARG MESOSPHERE_PREFIX="/opt/mesosphere"
ARG MESOS_JAR_SHA1="aab2e3118b01536af38c3b4243224149c625f008"
ARG MESOS_MAVEN_URL="https://repo1.maven.org/maven2/org/apache/mesos/mesos"
ARG MESOS_PROTOBUF_JAR_SHA1="bfb740747d97e5781c7f6c04bbfa93f5c2df0d4f"
ARG MESOS_VERSION="1.7.0"
ARG MESOSPHERE_DATA_TOOLKIT_VERSION="1.0.0-1.0.0"
ARG OPENRESTY_REPO="https://openresty.org/package"
ARG SPARK_DIST_URL="https://downloads.mesosphere.com/mesosphere-jupyter-service/assets/spark"
ARG SPARK_DIST_SHA256="52e29e83a65688e29da975d1ace7815c6a5b55e76c41d43a28e5e80de2b29843"
ARG SPARK_HOME="/opt/spark"
ARG SPARK_MAJOR_VERSION="2.2"
ARG SPARK_VERSION="2.2.1"
ARG TENSORFLOW_ECO_URL="https://downloads.mesosphere.com/mesosphere-jupyter-service/assets/tensorflow"
ARG TENSORFLOW_HADOOP_JAR_SHA256="668b326be1a7cfa4e621e8abaa9a5dbf1a813bad289ba0ad03e983ae8e841290"
ARG TENSORFLOW_SPARK_JAR_SHA256="bcc3bcb48cfe72997f7c51e6fd8d379c64d26fd200cbd08617631fd8182a2fbf"
ARG TENSORFLOW_JAR_SHA256="6a4e5c80bad7c826233a9b1750a7d4b5a28c6e5c8fccebefc1e6a0d5feeae4a3"
ARG TENSORFLOW_JNI_SHA256="8f74ced6dece0e0889eb09b0731ef728feffe0aadadaf8d6401a3ff15aafcc6e"
ARG TENSORFLOW_SERVING_APT_URL="http://storage.googleapis.com/tensorflow-serving-apt"
ARG TENSORFLOW_SERVING_VERSION="1.11.0"
ARG TENSORFLOW_URL="https://storage.googleapis.com/tensorflow"
ARG TENSORFLOW_VARIANT="cpu"
ARG TENSORFLOW_VERSION="1.11.0"
ARG TINI_GPG_KEY="595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7"
ARG TINI_URL="https://github.com/krallin/tini/releases/download"
ARG TINI_VERSION="v0.18.0"
ARG VCS_REF
ARG XGBOOST_JAVA_JAR_SHA256="4a6599ee3f1bd10d984e8b03747d5bc3cb637aeb791474178de2c285857bf69e"
ARG XGBOOST_SPARK_JAR_SHA256="cd31fb96b26fee197e126215949bc4f5c9a3cafd7ff157ab0037a63777c2935e"
ARG XGBOOST_URL="https://downloads.mesosphere.com/mesosphere-jupyter-service/assets/xgboost"
ARG XGBOOST_VERSION="0.71"

LABEL maintainer="Mesosphere Support <support+data-toolkit@mesosphere.com>" \
      org.label-schema.build-date="${BUILD_DATE}" \
      org.label-schema.name="Mesosphere Data Analytics Toolkit" \
      org.label-schema.description="Data Analytics Docker Image bundled with popular tools, libraries and frameworks." \
      org.label-schema.url="https://mesosphere.com" \
      org.label-schema.vcs-ref="${VCS_REF}" \
      org.label-schema.vcs-url="https://github.com/mesosphere/mesosphere-jupyter-service" \
      org.label-schema.version="${MESOSPHERE_DATA_TOOLKIT_VERSION}" \
      org.label-schema.schema-version="1.0"

ENV BOOTSTRAP="${MESOSPHERE_PREFIX}/bin/bootstrap" \
    CODENAME=${CODENAME:-"stretch"} \
    CONDA_DIR=${CONDA_DIR:-"/opt/conda"} \
    DEBCONF_NONINTERACTIVE_SEEN=${DEBCONF_NONINTERACTIVE_SEEN:-"true"} \
    DEBIAN_FRONTEND=${DEBIAN_FRONTEND:-"noninteractive"} \
    DISTRO=${DISTRO:-"debian"} \
    GPG_KEYSERVER=${GPG_KEYSERVER:-"hkps://zimmermann.mayfirst.org"} \
    HADOOP_HDFS_HOME=${HADOOP_HDFS_HOME:-"/opt/hadoop"} \
    HOME=${HOME:-"/root"} \
    JAVA_HOME=${JAVA_HOME:-"/opt/jdk"} \
    LANG=${LANG:-"en_US.UTF-8"} \
    LANGUAGE=${LANGUAGE:-"en_US.UTF-8"} \
    LC_ALL=${LC_ALL:-"en_US.UTF-8"} \
    MESOSPHERE_PREFIX=${MESOSPHERE_PREFIX:-"/opt/mesosphere"} \
    MESOS_AUTHENTICATEE="com_mesosphere_dcos_ClassicRPCAuthenticatee" \
    MESOS_HTTP_AUTHENTICATEE="com_mesosphere_dcos_http_Authenticatee" \
    MESOS_MODULES="{\"libraries\": [{\"file\": \"libdcos_security.so\", \"modules\": [{\"name\": \"com_mesosphere_dcos_ClassicRPCAuthenticatee\"}]}]}" \
    MESOS_NATIVE_LIBRARY="${MESOSPHERE_PREFIX}/libmesos-bundle/lib/libmesos.so" \
    MESOS_NATIVE_JAVA_LIBRARY="${MESOSPHERE_PREFIX}/libmesos-bundle/lib/libmesos.so" \
    NODE_OPTIONS="--max-old-space-size=8192" \
    PATH="${JAVA_HOME}/bin:${SPARK_HOME}/bin:${HADOOP_HDFS_HOME}/bin:${CONDA_DIR}/bin:${MESOSPHERE_PREFIX}/bin:${PATH}" \
    SHELL="/bin/bash" \
    SPARK_HOME=${SPARK_HOME:-"/opt/spark"}

RUN echo "deb ${DEBIAN_REPO}/${DISTRO} ${CODENAME} main" >> /etc/apt/sources.list \
    && echo "deb ${DEBIAN_REPO}/${DISTRO}-security ${CODENAME}/updates main" >> /etc/apt/sources.list \
    && apt-get update -yq --fix-missing \
    && apt-get install -yq --no-install-recommends apt-transport-https apt-utils ca-certificates curl dirmngr gnupg2 locales \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen \
    && curl --retry 3 -fsSL https://openresty.org/package/pubkey.gpg -o /tmp/openresty-pubkey.gpg \
    && apt-key add /tmp/openresty-pubkey.gpg \
    && rm /tmp/openresty-pubkey.gpg \
    && echo "deb ${OPENRESTY_REPO}/${DISTRO} ${CODENAME} openresty" > /etc/apt/sources.list.d/openresty.list \
    && apt-get update -yq --fix-missing \
    && apt-get -yq dist-upgrade \
    && apt-get install -yq --no-install-recommends \
       bash-completion \
       bzip2 \
       cmake \
       dnsutils \
       ffmpeg \
       g++ \
       gcc \
       git \
       info \
       jq \
       kstart \
       less \
       libaio1 \
       luarocks \
       make \
       man \
       netcat \
       openresty \
       openresty-opm \
       openssh-client \
       procps \
       psmisc \
       rsync \
       runit \
       sudo \
       sssd \
       unzip \
       vim \
       wget \
       zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && opm get zmartzone/lua-resty-openidc \
    && rm -rf ~/.opm/cache \
    && chmod ugo+rw /usr/local/openresty/nginx/logs \
    && chmod ugo+rw /usr/local/openresty/nginx \
    && addgroup --gid 99 nobody \
    && usermod -u 99 -g 99 nobody \
    && echo "nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin" >> /etc/passwd \
    && usermod -a -G users nobody

RUN cd /tmp \
    && apt-key adv --no-tty --keyserver "${GPG_KEYSERVER}" --recv-keys "${TINI_GPG_KEY}" \
    && curl --retry 3 -fsSL "${TINI_URL}/${TINI_VERSION}/tini" -o /usr/bin/tini \
    && curl --retry 3 -fsSL -O "${TINI_URL}/${TINI_VERSION}/tini.asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --no-tty --keyserver "${GPG_KEYSERVER}" --recv-keys "${TINI_GPG_KEY}" \
    && gpg --no-tty --batch --verify tini.asc /usr/bin/tini \
    && rm -rf "${GNUPGHOME}" tini.asc \
    && chmod +x /usr/bin/tini \
    && mkdir -p "${CONDA_DIR}" "${HADOOP_HDFS_HOME}" "${JAVA_HOME}" "${MESOSPHERE_PREFIX}/bin" "${SPARK_HOME}" \
    && curl --retry 3 -fsSL -O "${LIBMESOS_BUNDLE_URL}/libmesos-bundle-${LIBMESOS_BUNDLE_VERSION}.tar.gz" \
    && echo "${LIBMESOS_BUNDLE_SHA256}" "libmesos-bundle-${LIBMESOS_BUNDLE_VERSION}.tar.gz" | sha256sum -c - \
    && tar xf "libmesos-bundle-${LIBMESOS_BUNDLE_VERSION}.tar.gz" -C "${MESOSPHERE_PREFIX}" \
    && cd "${MESOSPHERE_PREFIX}/libmesos-bundle/lib" \
    && curl --retry 3 -fsSL -O "${MESOS_MAVEN_URL}/${MESOS_VERSION}/mesos-${MESOS_VERSION}.jar" \
    && echo "${MESOS_JAR_SHA1} mesos-${MESOS_VERSION}.jar" | sha1sum -c - \
    && curl --retry 3 -fsSL -O "${MESOS_MAVEN_URL}/${MESOS_VERSION}/mesos-${MESOS_VERSION}-shaded-protobuf.jar" \
    && echo "${MESOS_PROTOBUF_JAR_SHA1} mesos-${MESOS_VERSION}-shaded-protobuf.jar" | sha1sum -c - \
    && cd /tmp \
    && curl --retry 3 -fsSL -O "${DCOS_COMMONS_URL}/artifacts/${DCOS_COMMONS_VERSION}/bootstrap.zip" \
    && unzip "bootstrap.zip" -d "${MESOSPHERE_PREFIX}/bin/" \
    && curl --retry 3 -fsSL "${DCOS_CLI_URL}/dcos-${DCOS_CLI_VERSION}/dcos" -o ${MESOSPHERE_PREFIX}/bin/dcos \
    && chmod +x ${MESOSPHERE_PREFIX}/bin/dcos \
    && curl --retry 3 -fsSL -O "${JAVA_URL}/server-jre-${JAVA_VERSION}-linux-x64.tar.gz" \
    && tar xf "server-jre-${JAVA_VERSION}-linux-x64.tar.gz" -C "${JAVA_HOME}" --strip-components=1 \
    && curl --retry 3 -fsSL -O "${HADOOP_URL}/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" \
    && echo "${HADOOP_SHA256}" "hadoop-${HADOOP_VERSION}.tar.gz" | sha256sum -c - \
    && tar xf "hadoop-${HADOOP_VERSION}.tar.gz" -C "${HADOOP_HDFS_HOME}" --strip-components=1 \
    && rm -rf "${HADOOP_HDFS_HOME}/share/doc" \
    && curl --retry 3 -fsSL -O "${SPARK_DIST_URL}/spark-${SPARK_VERSION}-bin.tgz" \
    && echo "${SPARK_DIST_SHA256}" "spark-${SPARK_VERSION}-bin.tgz" | sha256sum -c - \
    && tar xf "spark-${SPARK_VERSION}-bin.tgz" -C "${SPARK_HOME}" --strip-components=1 \
    && cd "${SPARK_HOME}/jars" \
    && curl --retry 3 -fsSL -O "${XGBOOST_URL}/${XGBOOST_VERSION}/xgboost4j-${XGBOOST_VERSION}.jar" \
    && echo "${XGBOOST_JAVA_JAR_SHA256}" "xgboost4j-${XGBOOST_VERSION}.jar" | sha256sum -c - \
    && curl --retry 3 -fsSL -O "${XGBOOST_URL}/${XGBOOST_VERSION}/xgboost4j-spark-${XGBOOST_VERSION}.jar" \
    && echo "${XGBOOST_SPARK_JAR_SHA256}" "xgboost4j-spark-${XGBOOST_VERSION}.jar" | sha256sum -c - \
    && curl --retry 3 -fsSL -O "${TENSORFLOW_URL}/libtensorflow/libtensorflow-${TENSORFLOW_VERSION}.jar" \
    && echo "${TENSORFLOW_JAR_SHA256}" "libtensorflow-${TENSORFLOW_VERSION}.jar" | sha256sum -c - \
    && curl --retry 3 -fsSL -O "${TENSORFLOW_ECO_URL}/${TENSORFLOW_VERSION}/hadoop-${HADOOP_MAJOR_VERSION}/tensorflow-hadoop-${TENSORFLOW_VERSION}.jar" \
    && echo "${TENSORFLOW_HADOOP_JAR_SHA256}" "tensorflow-hadoop-${TENSORFLOW_VERSION}.jar" | sha256sum -c - \
    && curl --retry 3 -fsSL -O "${TENSORFLOW_ECO_URL}/${TENSORFLOW_VERSION}/spark-${SPARK_MAJOR_VERSION}/spark-tensorflow-connector_2.11-${TENSORFLOW_VERSION}.jar" \
    && echo "${TENSORFLOW_SPARK_JAR_SHA256}" "spark-tensorflow-connector_2.11-${TENSORFLOW_VERSION}.jar" | sha256sum -c - \
    && cd /tmp \
    && curl --retry 3 -fsSL -O "${TENSORFLOW_URL}/libtensorflow/libtensorflow_jni-${TENSORFLOW_VARIANT}-linux-x86_64-${TENSORFLOW_VERSION}.tar.gz" \
    && echo "${TENSORFLOW_JNI_SHA256}" "libtensorflow_jni-${TENSORFLOW_VARIANT}-linux-x86_64-${TENSORFLOW_VERSION}.tar.gz" | sha256sum -c - \
    && tar xf "libtensorflow_jni-${TENSORFLOW_VARIANT}-linux-x86_64-${TENSORFLOW_VERSION}.tar.gz" "./libtensorflow_jni.so" \
    && mv "libtensorflow_jni.so" "/usr/lib" \
    && rm -rf /tmp/*

RUN echo "deb [arch=amd64] ${TENSORFLOW_SERVING_APT_URL} stable tensorflow-model-server tensorflow-model-server-universal" > /etc/apt/sources.list.d/tensorflow-serving.list \
    && curl --retry 3 -fsSL ${TENSORFLOW_SERVING_APT_URL}/tensorflow-serving.release.pub.gpg | apt-key add - \
    && apt-get update \
    && TENSORFLOW_SERVING_DEB="$(mktemp)" \
    && curl --retry 3 -fsSL "${TENSORFLOW_SERVING_APT_URL}/pool/tensorflow-model-server-${TENSORFLOW_SERVING_VERSION}/t/tensorflow-model-server/tensorflow-model-server_${TENSORFLOW_SERVING_VERSION}_all.deb" -o "${TENSORFLOW_SERVING_DEB}"\
    && dpkg -i "${TENSORFLOW_SERVING_DEB}" \
    && rm -f "${TENSORFLOW_SERVING_DEB}" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY "${CONDA_ENV_YML}" "${CONDA_DIR}/"

RUN cd /tmp \
    && curl --retry 3 -fsSL -O "${CONDA_URL}/${CONDA_INSTALLER}" \
    && echo "${CONDA_MD5}  ${CONDA_INSTALLER}" | md5sum -c - \
    && bash "./${CONDA_INSTALLER}" -u -b -p "${CONDA_DIR}" \
    && ${CONDA_DIR}/bin/conda update --json --all -yq \
    && ${CONDA_DIR}/bin/conda config --env --add pinned_packages defaults::conda \
    && ${CONDA_DIR}/bin/conda config --env --add pinned_packages conda-forge::blas \
    && ${CONDA_DIR}/bin/conda config --env --add pinned_packages conda-forge::boost \
    && ${CONDA_DIR}/bin/conda config --env --add pinned_packages conda-forge::gsl \
    && ${CONDA_DIR}/bin/conda config --env --add pinned_packages conda-forge::numpy \
    && ${CONDA_DIR}/bin/conda config --env --add pinned_packages conda-forge::openblas \
    && ${CONDA_DIR}/bin/conda config --env --add pinned_packages conda-forge::scikit-learn \
    && ${CONDA_DIR}/bin/conda config --env --add pinned_packages conda-forge::scipy \
    && ${CONDA_DIR}/bin/conda config --system --prepend channels conda-forge \
    && ${CONDA_DIR}/bin/conda config --system --set auto_update_conda false \
    && ${CONDA_DIR}/bin/conda config --system --set show_channel_urls true \
    && ${CONDA_DIR}/bin/conda update --json -yq pip \
    && ${CONDA_DIR}/bin/conda env update --json -q -f "${CONDA_DIR}/${CONDA_ENV_YML}" \
    && ${CONDA_DIR}/bin/conda remove --force --json -yq openjdk pyqt qt qtconsole \
    && rm -rf "${HOME}/.cache/pip" "${HOME}/.cache/yarn" "${HOME}/.npm/_cacache" "${HOME}/.node-gyp" \
    && ${CONDA_DIR}/bin/conda clean --json -tipsy \
    && for dir in .conda/envs bin work; \
       do mkdir -p "${HOME}/${dir}"; done \
    && rm -rf /tmp/*

COPY profile "/etc/skel/.profile"
COPY profile "${HOME}/.profile"
COPY bash_profile "/etc/skel/.bash_profile"
COPY bash_profile "${HOME}/.bash_profile"
COPY bashrc "/etc/skel/.bashrc"
COPY bashrc "${HOME}/.bashrc"

RUN cp "${MESOSPHERE_PREFIX}/libmesos-bundle/lib/libcurl.so.4" /usr/lib/x86_64-linux-gnu/libcurl.so.4.4.0

ENV SPARK_DIST_CLASSPATH="${HADOOP_HDFS_HOME}/etc/hadoop:${HADOOP_HDFS_HOME}/share/hadoop/common/lib/*:${HADOOP_HDFS_HOME}/share/hadoop/common/*:${HADOOP_HDFS_HOME}/share/hadoop/hdfs:${HADOOP_HDFS_HOME}/share/hadoop/hdfs/lib/*:${HADOOP_HDFS_HOME}/share/hadoop/hdfs/*:${HADOOP_HDFS_HOME}/share/hadoop/yarn:${HADOOP_HDFS_HOME}/share/hadoop/yarn/lib/*:${HADOOP_HDFS_HOME}/share/hadoop/yarn/*:${HADOOP_HDFS_HOME}/share/hadoop/mapreduce/lib/*:${HADOOP_HDFS_HOME}/share/hadoop/mapreduce/*:${HADOOP_HDFS_HOME}/share/hadoop/tools/lib/*" \
    HADOOP_CLASSPATH="${HADOOP_CLASSPATH}:${HADOOP_HDFS_HOME}/share/hadoop/tools/lib/*" \
    PYTHONPATH="${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.4-src.zip:${PYTHONPATH}" \
    LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:${MESOSPHERE_PREFIX}/libmesos-bundle/lib:${JAVA_HOME}/jre/lib/amd64/server:${HADOOP_HDFS_HOME}/lib/native"

WORKDIR "/mnt/mesos/sandbox"

COPY krb5.conf.mustache /etc/
COPY hadoop-env.sh "${HADOOP_HDFS_HOME}/etc/hadoop/"
COPY hadooprc "${HOME}/.hadooprc"
COPY conf/ "${SPARK_HOME}/conf/"
COPY nginx /usr/local/openresty/nginx/

RUN chmod -R ugo+rw "${SPARK_HOME}/conf" \
    && cp "${CONDA_DIR}/share/examples/krb5/krb5.conf" /etc \
    && chmod ugo+rw /etc/krb5.conf \
    && chmod ugo+rw /usr/local/openresty/nginx/conf/nginx.conf \
    && chmod ugo+rw /usr/local/openresty/nginx/conf/sites/proxy.conf

COPY start-spark-history.sh /usr/local/bin/
COPY start-tensorboard.sh /usr/local/bin/
COPY start-worker.sh "/usr/local/bin/"
COPY start-dask-worker.sh "/usr/local/bin/"
COPY start-ray-worker.sh "/usr/local/bin/"
COPY ray-worker-health-check.sh "/usr/local/bin/"
