# GraalVM v1.0
#
# @see https://www.graalvm.org/docs/why-graal/
# docker run --rm supinf/graalvm:1.0

FROM debian:stretch-slim

ENV GRAAL_VERSION=1.0.0-rc13 \
    LANG=en_US.UTF-8

RUN apt-get update \
    && apt-get install -y "wget=1.18-5+deb9u2" \
    && repo=https://github.com/oracle/graal/releases/download \
    && wget -qO- "${repo}/vm-${GRAAL_VERSION}/graalvm-ce-${GRAAL_VERSION}-linux-amd64.tar.gz" \
       | tar xvz -C /opt/ \
    && rm -rf "/opt/graalvm-ce-${GRAAL_VERSION}/sample" \
        "/opt/graalvm-ce-${GRAAL_VERSION}/man" \
        "/opt/graalvm-ce-${GRAAL_VERSION}/src.zip" \
        "/opt/graalvm-ce-${GRAAL_VERSION}/jre/tools" \
        "/opt/graalvm-ce-${GRAAL_VERSION}/jre/languages" \
    && rm -rf /var/cache/* /var/lib/apt/lists/* /var/log/apt/*

ENV JAVA_HOME="/opt/graalvm-ce-${GRAAL_VERSION}/" \
    GRAALVM_HOME="/opt/graalvm-ce-${GRAAL_VERSION}" \
    PATH="${JAVA_HOME}bin:${PATH}"

RUN mkdir -p "/usr/java" \
    && ln -sfT "${JAVA_HOME}" /usr/java/default \
    && ln -sfT "${JAVA_HOME}" /usr/java/latest \
    && for bin in "${JAVA_HOME}bin/"*; do \
        base="$(basename "${bin}")"; \
        [ ! -e "/usr/bin/${base}" ]; \
        update-alternatives --install "/usr/bin/${base}" "${base}" "${bin}" 20000; \
    done

ENTRYPOINT ["java"]
CMD ["-version"]
