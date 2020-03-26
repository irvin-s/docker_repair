FROM microsoft/nanoserver
COPY manifest-tool manifest-tool.exe
ENTRYPOINT [ "manifest-tool.exe" ]
