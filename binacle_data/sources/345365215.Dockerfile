# AUTOGENERATED FILE
FROM balenalib/bananapi-m1-plus-debian:stretch-run

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        \
# .NET Core dependencies
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu57 \
        libssl1.1 \
        libstdc++6 \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Configure web servers to bind to port 80 when present
ENV ASPNETCORE_URLS=http://+:80 \
    # Enable detection of running in a container
    DOTNET_RUNNING_IN_CONTAINER=true

# Install .NET Core
ENV DOTNET_VERSION 3.0.0-preview5-27626-15

RUN curl -SL --output dotnet.tar.gz "https://dotnetcli.blob.core.windows.net/dotnet/Runtime/$DOTNET_VERSION/dotnet-runtime-$DOTNET_VERSION-linux-arm.tar.gz" \
    && dotnet_sha512='8B43F09C7832911EAED67BA6BFF4987226E06146B310A6762A63E1586CFB9FD0D466E7AE9B04E25D8D0C0E058B26C295BB4D31EA2A8FAAED8C519758ED089BDD' \
    && echo "$dotnet_sha512 dotnet.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

ENV ASPNETCORE_VERSION 3.0.0-preview5-19227-01

RUN curl -SL --output aspnetcore.tar.gz "https://dotnetcli.blob.core.windows.net/dotnet/aspnetcore/Runtime/$ASPNETCORE_VERSION/aspnetcore-runtime-$ASPNETCORE_VERSION-linux-arm.tar.gz" \
    && aspnetcore_sha512='8B43F09C7832911EAED67BA6BFF4987226E06146B310A6762A63E1586CFB9FD0D466E7AE9B04E25D8D0C0E058B26C295BB4D31EA2A8FAAED8C519758ED089BDD' \
    && echo "$aspnetcore_sha512  aspnetcore.tar.gz" | sha512sum -c - \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf aspnetcore.tar.gz -C /usr/share/dotnet ./shared/Microsoft.AspNetCore.App \
    && rm aspnetcore.tar.gz

CMD ["echo","'No CMD command was set in Dockerfile! Details about CMD command could be found in Dockerfile Guide section in our Docs. Here's the link: https://balena.io/docs"]