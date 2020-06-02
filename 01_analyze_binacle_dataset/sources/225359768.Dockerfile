FROM microsoft/dotnet:2.2-sdk
ARG VSN

RUN set -eux \
 && cd /root \
 && apt-get update \
 && apt-get upgrade -y \
 && wget https://www.foundationdb.org/downloads/${VSN}/ubuntu/installers/foundationdb-clients_${VSN}-1_amd64.deb \
 && dpkg -i *.deb \
 && rm -f *.deb \
 && git clone https://github.com/Doxense/foundationdb-dotnet-client.git --depth 1 fdb-dotnet \
 && cd fdb-dotnet \
 && sh ./build.sh \
 && echo '#!/bin/sh\nexec dotnet run -f netcoreapp2.2 -p /root/fdb-dotnet/FdbTop "$@"' > FdbTop/fdbtop \
 && chmod +x FdbTop/fdbtop

WORKDIR /root/fdb-dotnet/FdbTop
CMD ["./fdbtop"]
