FROM stefanscherer/whoami:windows-amd64-1.8.2-1809 as bin
FROM mcr.microsoft.com/windows/nanoserver/insider:10.0.18298.1000

COPY --from=bin /http.exe /http.exe

EXPOSE 8080

CMD ["\\http.exe"]
