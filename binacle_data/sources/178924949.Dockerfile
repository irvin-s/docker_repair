FROM mono:latest

WORKDIR /inengine
ADD . /inengine

ENTRYPOINT ["mono", "./InEngine.exe"]
