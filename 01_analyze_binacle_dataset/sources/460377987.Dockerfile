FROM soletic/sshd
MAINTAINER Sol&TIC <serveur@soletic.org>

ENV CHROOT_INSTALL_DIR /chroot
# Path to directory where user directories are stored
ENV CHROOT_USERS_HOME_DIR /home
# Absolute dir path from a home user dir that will be mounted as home dir in the chroot environment
ENV CHROOT_USER_HOME_BASEPATH ""

ADD sshd_config_addons /etc/ssh/sshd_config_addons
RUN groupadd sshusers
RUN sed -ri -e 's/^Subsystem sftp.*/Subsystem sftp internal-sftp/' /etc/ssh/sshd_config
RUN cat /etc/ssh/sshd_config_addons >> /etc/ssh/sshd_config

RUN mkdir -p /chroot/plugins

# Bin utils
ADD l2chroot.sh /l2chroot.sh
ADD chroot.sh /chroot.sh
ADD install_bin.sh /install_bin.sh
ADD install_bin.sh /install_bin-add.sh
RUN chmod 755 /*.sh

# Start program
ADD supervisor-sshchrooted.conf /etc/supervisor/conf.d/supervisor-sshchrooted.conf
ADD ssh-chrooted-setup.sh /root/scripts/ssh-chrooted-setup.sh
RUN chmod 755 /root/scripts/*.sh
