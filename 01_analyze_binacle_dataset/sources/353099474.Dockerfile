FROM rvo/vsobuildagent:Base

COPY run.bat /agent
WORKDIR /agent

ENTRYPOINT run.bat
#CMD .\agent\VsoAgent.exe /configure /serverUrl:%vso_url% /name:%vso_agentname% /Poolname:%vso_agentpool% /Login:rvanosnabrugge,H3ll0W0rld!;AuthType=Basic /force /workfolder:"c:\agent\_work" /runningasservice:N /noprompt /force
#.\agent\VsoAgent.exe /configure /serverUrl:https://osnabrugge.visualstudio.com /name:%vso_agentname% /Poolname:%vso_agentpool% /Login:%vso_username%,%vso_password%;AuthType=Basic /force /workfolder:"c:\agent\_work" /runningasservice:N /noprompt /force

