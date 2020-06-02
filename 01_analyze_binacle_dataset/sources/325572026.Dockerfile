FROM sailfishos-platform-sdk-base
MAINTAINER Lucien Xu <sfietkonstantin@free.fr>

# Add nemo in sudoers without password
RUN chmod +w /etc/sudoers && echo "nemo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && chmod -w /etc/sudoers

USER nemo

RUN sudo zypper in -y tar
RUN sdk-assistant -y create SailfishOS-latest \
    http://releases.sailfishos.org/sdk/latest/Jolla-latest-Sailfish_SDK_Tooling-i486.tar.bz2
COPY mer-tooling-chroot /srv/mer/toolings/SailfishOS-latest/

RUN sdk-assistant -y create SailfishOS-latest-armv7hl \
    http://releases.sailfishos.org/sdk/latest/Jolla-latest-Sailfish_SDK_Target-armv7hl.tar.bz2

RUN sdk-assistant -y create SailfishOS-latest-i486 \
    http://releases.sailfishos.org/sdk/latest/Jolla-latest-Sailfish_SDK_Target-i486.tar.bz2
