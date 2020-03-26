FROM ubuntu:18.04
ARG LIBRARY=@azure/cosmos
ARG LIBRARY_FOLDER=src
EXPOSE 1900
RUN apt-get update \
    && apt-get install nodejs --yes \
    && apt-get install npm --yes \
    && apt-get install unzip --yes \
    && apt-get install wget --yes \
    && apt-get install socat --yes \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt update \
    && apt install mono-complete --yes \
    && mkdir munseo \
    && cd munseo \
    && wget https://github.com/dotnet/docfx/releases/download/v2.39.1/docfx.zip \
    && unzip docfx.zip -d _docfx \
    && mkdir _docs \
    && cd _docs \
    && mono ../_docfx/docfx.exe init -q \
    && cd .. \
    && npm install typedoc --save-dev --global \
    && npm install type2docfx --save-dev --global \
    && npm install $LIBRARY --prefix _package \
    && typedoc --mode file --json _output.json _package/node_modules/$LIBRARY/$LIBRARY_FOLDER -ignoreCompilerErrors \
    && type2docfx _output.json _yaml \
    && cp -a _yaml/. _docs/docfx_project/api/ \
    && cd _docs/docfx_project \
    && mono ../../_docfx/docfx.exe \
    && cd ../.. \
    && echo -e "socat TCP4-LISTEN:1900,bind=`hostname -I | tr -d '[:space:]'`,fork TCP4:localhost:8080 &\ncd /munseo/_docs/docfx_project\nmono ../../_docfx/docfx.exe serve _site" >> rundocs.sh
ENTRYPOINT ["sh", "/munseo/rundocs.sh"]