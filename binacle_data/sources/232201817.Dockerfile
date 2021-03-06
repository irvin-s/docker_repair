# escape=`
FROM  sixeyed/jenkins:2.121.1-windowsservercore-ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR C:\git
COPY --from=sixeyed/git:2.17.1-windowsservercore-ltsc2016 C:\git .

WORKDIR C:\docker
COPY --from=sixeyed/docker-ee:18.03-windowsservercore-ltsc2016 ["C:\\Program Files\\Docker",  "."]

RUN $env:PATH = 'C:\docker;' + 'C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)