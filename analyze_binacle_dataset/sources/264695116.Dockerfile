FROM ref12/esimage-5.5.1:ES_5.5.1
WORKDIR /app
EXPOSE 80
EXPOSE 443

COPY bin/app .

SHELL ["powershell.exe", "-Command"]

# Create a data volume and map it to the G: drive, allowing Java to call Path.toRealPath() successfully
RUN Set-Variable -Name 'regpath' -Value 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' ; \
    Set-ItemProperty -path $regpath -Name 'G:' -Value '\??\C:\app' -Type String ;

ENTRYPOINT ["dotnet", "Codex.Web.Mvc.dll"]
