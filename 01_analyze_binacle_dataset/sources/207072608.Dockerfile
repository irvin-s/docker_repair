FROM unocha/alpine-base-munin

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

ENV LANG=en_US.utf8

COPY init_cont run_munin_node fix_dirs /tmp/

RUN mkdir -p /etc/services.d/munin-node && \
    mv /tmp/run_munin_node /etc/services.d/munin-node/run && \
    mv /tmp/fix_dirs /etc/fix-attrs.d/01-fix-dirs && \
    mv /tmp/init_cont /etc/cont-init.d/20-create-folders && \
    sed -ri '\
        s/^log_file.*/# \0/; \
        s/^pid_file.*/# \0/; \
        s/^background 1$/background 0/; \
        s/^setsid 1$/setsid 0/; \
        ' /etc/munin/munin-node.conf && \
    echo "cidr_allow 10.0.0.0/8" >> /etc/munin/munin-node.conf && \
    echo "cidr_allow 172.16.0.0/12" >> /etc/munin/munin-node.conf && \
    echo "cidr_allow 192.168.0.0/16" >> /etc/munin/munin-node.conf && \
    ln -sf /usr/lib/munin/plugins/cpu /etc/munin/plugins/cpu && \
    ln -sf /usr/lib/munin/plugins/diskstats /etc/munin/plugins/diskstats && \
    ln -sf /usr/lib/munin/plugins/entropy /etc/munin/plugins/entropy && \
    ln -sf /usr/lib/munin/plugins/forks /etc/munin/plugins/forks && \
    ln -sf /usr/lib/munin/plugins/fw_packets /etc/munin/plugins/fw_packets && \
    ln -sf /usr/lib/munin/plugins/if_err_ /etc/munin/plugins/if_err_eth0 && \
    ln -sf /usr/lib/munin/plugins/if_ /etc/munin/plugins/if_eth0 && \
    ln -sf /usr/lib/munin/plugins/interrupts /etc/munin/plugins/interrupts && \
    ln -sf /usr/lib/munin/plugins/irqstats /etc/munin/plugins/irqstats && \
    ln -sf /usr/lib/munin/plugins/load /etc/munin/plugins/load && \
    ln -sf /usr/lib/munin/plugins/memory /etc/munin/plugins/memory && \
    ln -sf /usr/lib/munin/plugins/munin_stats /etc/munin/plugins/munin_stats && \
    ln -sf /usr/lib/munin/plugins/open_files /etc/munin/plugins/open_files && \
    ln -sf /usr/lib/munin/plugins/open_inodes /etc/munin/plugins/open_inodes && \
    ln -sf /usr/lib/munin/plugins/proc_pri /etc/munin/plugins/proc_pri && \
    ln -sf /usr/lib/munin/plugins/processes /etc/munin/plugins/processes && \
    ln -sf /usr/lib/munin/plugins/swap /etc/munin/plugins/swap && \
    ln -sf /usr/lib/munin/plugins/threads /etc/munin/plugins/threads && \
    ln -sf /usr/lib/munin/plugins/uptime /etc/munin/plugins/uptime && \
    ln -sf /usr/lib/munin/plugins/users /etc/munin/plugins/users


    #munin-node-configure --remove --shell | sh

# you need to run this as a privileged container, in net host mode
# and mount readonly / as /rootfs, /proc as /proc, /sys as /sys
