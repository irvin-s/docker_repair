FROM consol/omd-labs-centos:nightly
COPY playbook.yml /root/ansible_dropin/
COPY thruk_local.conf /root/
COPY *.tbp /root/
