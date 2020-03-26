FROM ubuntu:18.04
SHELL ["/bin/bash", "-c"] 
ARG LIBRARY=https://github.com/Azure/azure-storage-python
ARG LIBRARY_FOLDER=azure-storage-blob
EXPOSE 1900
RUN apt-get update \
    && apt-get install python3.6 --yes \
    && apt-get install python3-pip --yes \
    && apt-get install git --yes \
    && apt-get install unzip --yes \
    && apt-get install wget --yes \
    && apt-get install socat --yes \
    && apt-get install gnupg2 --yes \
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
    && mkdir _project \
    && git clone $LIBRARY _project \
    && pip3 install sphinx-docfx-yaml \
    # Install dependent packages
    && pip3 install azure \
    # Process all other stuff.
    && cd _project \
    && cd $LIBRARY_FOLDER \
    && sphinx-quickstart -q -p 'doctainers' -a 'automated' -v '1.0' \
    && sed -i "s/extensions.*/extensions = ['sphinx.ext.autodoc', 'docfx_yaml.extension']/" conf.py \
    && IMPORT_COMBINATION='import os\nimport sys\n' \
    && for combo in $(ls -d */ | cut -f1 -d"/"); do IMPORT_COMBINATION+="sys.path.append(os.path.abspath('$combo'))\n"; done \
    && echo -e $IMPORT_COMBINATION | cat - conf.py > temp && mv temp conf.py \
    && cat conf.py \
    && sphinx-apidoc . -o . --module-first --no-headings --no-toc --implicit-namespaces \
    && sphinx-build . _build \
    && ls _build/docfx_yaml \
    && cp -a _build/docfx_yaml/. ../../_docs/docfx_project/api/ \
    && cd ../../_docs/docfx_project \
    && mono ../../_docfx/docfx.exe \
    && cd ../.. \
    && echo -e "socat TCP-LISTEN:1900,fork,reuseaddr TCP:localhost:8080 &\ncd /munseo/_docs/docfx_project\nmono ../../_docfx/docfx.exe serve _site" >> rundocs.sh
ENTRYPOINT ["sh", "/munseo/rundocs.sh"]