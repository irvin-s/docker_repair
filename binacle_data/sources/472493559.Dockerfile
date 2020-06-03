FROM gozap/openjdk8:8u212

LABEL maintainer="mritd <mritd@linux.com>"

RUN apt update -y \
    && apt upgrade -y \
    && apt install -y unzip wget chromium chromium-driver \
        fontconfig fonts-ipafont-gothic fonts-wqy-zenhei \
        fonts-thai-tlwg fonts-kacst fonts-symbola \
        fonts-noto ttf-freefont --no-install-recommends \
    && apt autoremove -y \
    && apt autoclean -y \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
