FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"] 
ARG LIBRARY=@azure/cosmos
ARG LIBRARY_FOLDER=lib
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
    && apt install mono-devel --yes \
    && mkdir munseo \
    && cd munseo \
    && wget https://github.com/dotnet/docfx/releases/download/v2.39.1/docfx.zip \
    && unzip docfx.zip -d _docfx \
    && mkdir _docs \
    && cd _docs \
    && mono ../_docfx/docfx.exe init -q \
    && cd .. \
    && echo "Installing node2docfx..." \
    && npm install node2docfx --prefix _ntod \
    && echo "Installing library..." \
    && npm install $LIBRARY --prefix _package \
    && echo "Starting processing..." \
    && cd _package/node_modules/$LIBRARY \
    && files_to_process="" \
    && js_files=() \
    && while IFS=  read -r -d $'\0'; do js_files+=("$REPLY"); done < <(find $LIBRARY_FOLDER -name "*.js" -print0) \
    && for js_file in "${js_files[@]}"; do files_to_process+="\"$js_file\","; done \
    && files_to_process=${files_to_process::-1} \
    && echo $files_to_process \
    && file_content="{\"source\": {\"include\": [$files_to_process]},\"package\": \"package.json\",\"readme\": \"README.md\",\"destination\": \"_yaml\"}" \
    && echo $file_content >> node2docfx.json \
    && echo "Processing JavaScript..." \
    && node ../../../../_ntod/node_modules/node2docfx/node2docfx.js node2docfx.json \
    && cp -a _yaml/. ../../../../_docs/docfx_project/api/ \
    && cd ../../../../_docs/docfx_project \
    && mono ../../_docfx/docfx.exe \
    && cd ../.. \
    && echo -e "socat TCP-LISTEN:1900,fork,reuseaddr TCP:localhost:8080 &\ncd /munseo/_docs/docfx_project\nmono ../../_docfx/docfx.exe serve _site" >> rundocs.sh
ENTRYPOINT ["sh", "/munseo/rundocs.sh"]