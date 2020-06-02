FROM buildpack-deps:jessie-scm

# Install gettext for 'envsubst' command
RUN apt-get update \
  && apt-get install -y gettext \
  && rm -rf /var/lib/apt/lists/* /tmp/*

# Install mono
# Source: https://github.com/docker-library/docs/tree/master/mono

ENV MONO_VERSION 5.4.1.6

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF

RUN echo "deb http://download.mono-project.com/repo/debian jessie/snapshots/$MONO_VERSION main" > /etc/apt/sources.list.d/mono-official.list \
  && apt-get update \
  && apt-get install -y mono-runtime \
  && apt-get install -y binutils curl mono-devel ca-certificates-mono fsharp mono-vbnc nuget referenceassemblies-pcl \
  && rm -rf /var/lib/apt/lists/* /tmp/*

# Install .NET CLI dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libc6 \
        libcurl3 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu52 \
        liblttng-ust0 \
        libssl1.0.0 \
        libstdc++6 \
        libunwind8 \
        libuuid1 \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Install .NET Core SDK
# Source: https://github.com/dotnet/dotnet-docker

ENV DOTNET_SDK_VERSION 2.1.3
ENV DOTNET_SDK_DOWNLOAD_URL https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$DOTNET_SDK_VERSION/dotnet-sdk-$DOTNET_SDK_VERSION-linux-x64.tar.gz
ENV DOTNET_SDK_DOWNLOAD_SHA 509b88895fd5a6a90e245141eb52f188aa9ee7d20188c213892483c142900d6975013aef9ca6d8da986cc5617a2c3571e22318297c51578b871c047602757600

RUN curl -SL $DOTNET_SDK_DOWNLOAD_URL --output dotnet.tar.gz \
    && echo "$DOTNET_SDK_DOWNLOAD_SHA dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Trigger the population of the local package cache
ENV NUGET_XMLDOC_MODE skip
RUN mkdir warmup \
    && cd warmup \
    && dotnet new \
    && cd .. \
    && rm -rf warmup \
    && rm -rf /tmp/NuGetScratch


# Install Nuget

RUN mkdir -p /app/nuget
ENV NUGET_DOWNLOAD_URL https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
RUN curl -SL $NUGET_DOWNLOAD_URL --output /app/nuget/nuget.exe
ADD nuget.sh /app/nuget/nuget.sh
RUN chmod +x /app/nuget/nuget.sh
ADD nuget-pack.sh /app/nuget/nuget-pack.sh
RUN chmod +x /app/nuget/nuget-pack.sh

RUN mono --version
ENV PATH="/app/nuget:${PATH}"
RUN nuget.sh help
