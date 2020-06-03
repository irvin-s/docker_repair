FROM ubuntu
RUN apt-get -qq update && apt-get -qq install -y \
    git imagemagick curl gconf-service lib32gcc1 lib32stdc++6 libasound2 libc6 libc6-i386 libcairo2 libcap2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libfreetype6 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libgl1-mesa-glx libglib2.0-0 libglu1-mesa libgtk2.0-0 libnspr4 libnss3 libpango1.0-0 libstdc++6 libx11-6 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxtst6 zlib1g debconf npm xdg-utils lsb-release libpq5 xvfb libsoup2.4-1 libarchive13 libpng-dev python-pip python3-venv python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/.cache/unity3d && mkdir -p /root/.local/share/unity3d/Unity && mkdir -p /root/.local/share/unity3d/Certificates
ADD get-unity.sh /app/get-unity.sh
ADD run-unity.sh /app/run-unity.sh
ADD 5/Unity_v5.x.ulf /root/.local/share/unity3d/Unity/Unity_v5.x.ulf
ADD 2017/Unity_lic.ulf /root/.local/share/unity3d/Unity/Unity_lic.ulf
ADD CACerts.pem /root/.local/share/unity3d/Certificates/CACerts.pem
RUN chmod +x /app/get-unity.sh && \
    chmod +x /app/run-unity.sh
RUN /app/get-unity.sh
ENV PATH="/app:${PATH}"
