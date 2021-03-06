# escape=`

# Stage 0: prepare files
ARG BASE_IMAGE
FROM ${BASE_IMAGE} as builder

ARG COMMERCE_SIF_PACKAGE
ARG COMMERCE_CONNECT_PACKAGE
ARG COMMERCE_MA_PACKAGE
ARG COMMERCE_MA_FOR_AUTOMATION_ENGINE_PACKAGE
ARG COMMERCE_XPROFILES_PACKAGE
ARG COMMERCE_XANALYTICS_PACKAGE

SHELL ["powershell", "-NoProfile", "-Command", "$ErrorActionPreference = 'Stop';"]

COPY files/ /Files/

RUN Expand-Archive -Path "/Files/$Env:COMMERCE_SIF_PACKAGE" -DestinationPath /Files/CommerceSIF -Force; `
    Expand-Archive -Path "/Files/$Env:COMMERCE_CONNECT_PACKAGE" -DestinationPath /Files/SitecoreCommerceConnectCore -Force; `
    Expand-Archive -Path "/Files/$Env:COMMERCE_MA_PACKAGE" -DestinationPath /Files/CommerceMACore -Force; `
    Expand-Archive -Path "/Files/$Env:COMMERCE_MA_FOR_AUTOMATION_ENGINE_PACKAGE" -DestinationPath /Files/CommerceMACoreForAE -Force; `
    Expand-Archive -Path "/Files/$Env:COMMERCE_XPROFILES_PACKAGE" -DestinationPath /Files/CommerceXProfiles -Force; `
    Expand-Archive -Path "/Files/$Env:COMMERCE_XANALYTICS_PACKAGE" -DestinationPath /Files/CommerceXAnalytics -Force

# Stage 1: perform actual build
FROM ${BASE_IMAGE}

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG COMMERCE_CERT_PATH
ARG WEB_TRANSFORM_TOOL
ARG COMMERCE_CONNECT_ENGINE_PACKAGE

COPY --from=builder /Files/CommerceSIF /Files/CommerceSIF/
COPY --from=builder /Files/SitecoreCommerceConnectCore /Files/SitecoreCommerceConnectCore
COPY --from=builder /Files/CommerceMACore /Files/CommerceMACore
COPY --from=builder /Files/CommerceMACoreForAE /Files/CommerceMACoreForAE
COPY --from=builder /Files/CommerceXProfiles /Files/CommerceXProfiles
COPY --from=builder /Files/CommerceXAnalytics /Files/CommerceXAnalytics
COPY --from=builder /Files/${WEB_TRANSFORM_TOOL} /Files/Microsoft.Web.XmlTransform.dll
COPY --from=builder /Files/${COMMERCE_CONNECT_ENGINE_PACKAGE} /Files/Sitecore.Commerce.Engine.Connect.zip
COPY files/$COMMERCE_CERT_PATH /Files/
COPY scripts/Import-Certificate.ps1 /Scripts/

# Import commerce certificate
RUN /Scripts/Import-Certificate.ps1 -certificateFile /Files/$Env:COMMERCE_CERT_PATH -secret 'secret' -storeName 'My' -storeLocation 'LocalMachine';

COPY xc/sitecore/InstallCommercePackages.ps1 /Scripts/

COPY xc/sitecore/UpdateHostnames.ps1 /Scripts
COPY xc/sitecore/Boot.ps1 C:/

ENTRYPOINT ["powershell", "C:/Boot.ps1"]
CMD [ "-commerceHostname commerce.local -identityHostname identity" ]