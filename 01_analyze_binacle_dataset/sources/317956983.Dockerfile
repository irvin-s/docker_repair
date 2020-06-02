# Use Ubuntu 16.04 + wine-staging as a base for MSVC2017
FROM boberfly/docker-wine:latest as builder

# For running anything headless in wine that needs a GUI, and 7zip
RUN apt-get update && apt-get install -y xvfb p7zip-full

# To get VisualCpp
RUN apt-get install -y nuget ca-certificates-mono \
# Clean up
    && apt-get autoremove -y \
        software-properties-common \
    && apt-get autoclean \
    && apt-get clean \
    && apt-get autoremove
# This one makes it so the certificates get picked up by nuget
ENV TZ=UTC

# For a headless wine experience, why not try xvfb?
COPY xvfb-start.sh /usr/bin/xvfb-start

# From now onwards we take the role of the wine user
USER wine:wine

# Now we grab MSVC 2017 Community from Nuget
WORKDIR /home/wine
RUN nuget install VisualCppTools.Community.VS2017Layout -Version 14.11.25506 \
    && rm VisualCppTools.Community.VS2017Layout.14.11.25506/VisualCppTools.Community.VS2017Layout.14.11.25506.nupkg \
    && nuget install Git-Windows-Minimal -Version 2.17.0 \
    && rm Git-Windows-Minimal.2.17.0/Git-Windows-Minimal.2.17.0.nupkg
# Download the Windows SDK, uncomment COPY and comment out ADD if you have the sdk local and named win10sdk.iso
#COPY --chown=wine:wine win10sdk.iso /home/wine/win10sdk.iso
ADD --chown=wine:wine https://go.microsoft.com/fwlink/p/?linkid=870809 /home/wine/win10sdk.iso

# Python 2.7
ADD --chown=wine:wine https://www.python.org/ftp/python/2.7.15/python-2.7.15.amd64.msi python.msi

# This convoluted RUN will extract and install the .msi's we are interested in for building against Windows 10
RUN xvfb-start && export DISPLAY=:99 \
    && mkdir /home/wine/win10sdk && cd /home/wine/win10sdk && 7z x ../win10sdk.iso && rm ../win10sdk.iso \
    && cd Installers && wine wineboot --init \
    && wine msiexec /i "Windows SDK Desktop Headers x64-x86_en-us.msi" /qn \
    && wine msiexec /i "Windows SDK Desktop Headers x86-x86_en-us.msi" /qn \ 
    && wine msiexec /i "Windows SDK Desktop Libs x64-x86_en-us.msi" /qn \ 
    && wine msiexec /i "Windows SDK Desktop Libs x86-x86_en-us.msi" /qn \ 
    && wine msiexec /i "Windows SDK Desktop Tools x64-x86_en-us.msi" /qn \
    && wine msiexec /i "Windows SDK Desktop Tools x86-x86_en-us.msi" /qn \
    && wine msiexec /i "Windows SDK for Windows Store Apps Headers-x86_en-us.msi" /qn \
    && wine msiexec /i "Windows SDK for Windows Store Apps Libs-x86_en-us.msi" /qn \
    && wine msiexec /i "Windows SDK for Windows Store Apps Tools-x86_en-us.msi" /qn \
    && wine msiexec /i "Windows SDK for Windows Store Apps Legacy Tools-x86_en-us.msi" /qn \
    && wine msiexec /i "Universal CRT Headers Libraries and Sources-x86_en-us.msi" /qn \
# Lets install Python while we're here
    && wine msiexec /i "Z:\home\wine\python.msi" /qn \
    && cd /home/wine && rm -rf win10sdk && rm python.msi

WORKDIR /home/wine/.wine/drive_c
# Time to grab CMake and friends.
ADD --chown=wine:wine https://cmake.org/files/v3.10/cmake-3.10.3-win64-x64.zip cmake.zip
ADD --chown=wine:wine https://github.com/ninja-build/ninja/releases/download/v1.8.2/ninja-win.zip ninja.zip
ADD --chown=wine:wine http://download.qt.io/official_releases/jom/jom.zip jom.zip
RUN 7z x cmake.zip && rm cmake.zip \
    && mkdir ninja && cd ninja && 7z x ../ninja.zip && cd .. && rm ninja.zip \
    && mkdir jom && cd jom && 7z x ../jom.zip && cd .. && rm jom.zip

USER root
# END




# Now lets make a lighter image
FROM boberfly/docker-wine:latest
WORKDIR /opt/
COPY --from=builder /home/wine/VisualCppTools.Community.VS2017Layout.14.11.25506 msvc2017
COPY --from=builder ["/home/wine/.wine/drive_c/Program Files (x86)/Windows Kits/10", "win10sdk"]
COPY --from=builder /home/wine/.wine/drive_c/cmake-3.10.3-win64-x64 cmake
COPY --from=builder /home/wine/.wine/drive_c/ninja ninja
COPY --from=builder /home/wine/.wine/drive_c/jom jom
COPY --from=builder /home/wine/.wine/drive_c/Python27 python27
COPY --from=builder /home/wine/Git-Windows-Minimal.2.17.0 git
COPY --from=builder /usr/bin/xvfb-start /usr/bin/xvfb-start
RUN apt-get install -y xvfb git nano \
# Clean up
    && apt-get autoremove -y \
        software-properties-common \
    && apt-get autoclean \
    && apt-get clean \
    && apt-get autoremove
USER wine:wine
RUN xvfb-start && export DISPLAY=:99 && wine wineboot --init \
    && winetricks -q vcrun2017 cmd && winetricks -q win7
# Copy an env we prepared earlier
COPY --chown=wine:wine msvc2017x64env.bat /home/wine/.wine/drive_c/msvc2017x64env.bat
COPY entrypoint_msvc.sh /usr/bin/entrypoint_msvc
# Symlink all the things!
WORKDIR /home/wine/.wine/drive_c/
RUN ln -s /opt/msvc2017 msvc2017 \ 
    && ln -s /opt/win10sdk win10sdk \
    && ln -s /opt/cmake cmake \
    && ln -s /opt/ninja ninja \
    && ln -s /opt/jom jom \
    && ln -s /opt/python27 python27 \
    && ln -s /opt/git git

USER root
# vctip.exe is a telemetry tool which isn't needed and it causes weird stack traces in cmd...
RUN rm /opt/msvc2017/lib/native/bin/Hostx64/x64/VCTIP.exe && \
    rm /opt/msvc2017/lib/native/bin/Hostx64/x86/VCTIP.exe && \
    rm /opt/msvc2017/lib/native/bin/Hostx86/x64/VCTIP.exe && \
    rm /opt/msvc2017/lib/native/bin/Hostx86/x86/VCTIP.exe

# So that when docker runs we can copy over the guts to a volume
#VOLUME /home/wine

# Start with a generic entrypoint.
ENTRYPOINT ["/usr/bin/entrypoint_msvc"]

# Default to cmd with MSVC 2017 64-bit as the default target.
CMD ["/usr/bin/entrypoint_msvc"]
