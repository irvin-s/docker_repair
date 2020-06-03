FROM microsoft/iis

RUN mkdir C:\site

RUN powershell -NoProfile -Command \
    Import-module IISAdministration; \
    New-IISSite -Name "Talks" -PhysicalPath C:\site -BindingInformation "*:8000:"; \
    Add-WebConfiguration -Filter system.webServer/staticContent -AtIndex 0 -Value @{fileExtension='md'; mimeType='application/markdown'}

COPY . C:\site

EXPOSE 8000
