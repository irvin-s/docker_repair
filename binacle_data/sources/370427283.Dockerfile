FROM registry.suse.com/sles12sp2

RUN zypper --non-interactive rm container-suseconnect &&\
    zypper --non-interactive ar \
      http://download.suse.de/ibs/SUSE/Products/SLE-SERVER/12-SP2/x86_64/product/ sles12sp2_pool &&\
    zypper --non-interactive ar \
      http://download.suse.de/ibs/SUSE/Updates/SLE-SERVER/12-SP2/x86_64/update sles12sp2_updates &&\
    zypper ar http://download.suse.de/ibs/SUSE/Products/SLE-SDK/12-SP2/x86_64/product sles12sp2_sdk &&\ 
    zypper ref && zypper --non-interactive install --no-recommend \
    timezone patch mariadb-client libopenssl-devel

ADD files/run.sh /root/run.sh

ENTRYPOINT ["/root/run.sh"]
CMD ["tail", "-f", "/dev/null"]
