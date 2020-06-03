FROM openshift/base-centos7

MAINTAINER Andrew Block <andy.block@gmail.com>

ENV \ 
    DOTNET_CORE_VERSION=1.0 \
    HOME=/opt/app-root/src

# Set the labels that are used for Openshift to describe the builder image.
LABEL io.k8s.description="ASP.NET Core 1.0" \
    io.k8s.display-name="ASP.NET Core 1.0" \
    io.openshift.expose-services="8080:http" \
    io.openshift.tags="builder,webserver,html,aspdotnet" \
    io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
    io.openshift.s2i.destination="/opt/app-root"

RUN yum install -y libunwind libicu && \
    yum clean all -y && \
    mkdir -p ${HOME} && \
    chown -R 1001:0 ${HOME}/ && \
    chown -R 1001:0 /opt/app-root && \
    curl -sSL -o /tmp/dotnet.tar.gz https://go.microsoft.com/fwlink/?LinkID=809131 && \
    mkdir -p /dotnet/ && tar zxf /tmp/dotnet.tar.gz -C /dotnet && \
    ln -s /dotnet/dotnet /usr/local/bin && \
    rm -rf /tmp/dotnet.tar.gz


EXPOSE 8080/tcp

COPY  ["s2i/run", "s2i/assemble", "s2i/save-artifacts", "s2i/usage", "/usr/libexec/s2i/"]

USER 1001

WORKDIR $HOME

CMD ["/usr/libexec/s2i/usage"]


