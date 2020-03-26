FROM centos:7  
MAINTAINER BelGoat <belgoat@gmail.com>  
  
ENV REPO_DOWNLOAD_LOCATION "/opt/repos"  
# Repo dir names Additions  
ENV REPO_NAME_PREFIX ""  
ENV REPO_NAME_POSTFIX ""  
# Repos to download  
ENV REPO_BASE_DOWNLOAD no  
ENV REPO_BASE_SOURCE_DOWNLOAD no  
ENV REPO_BASE_DEBUGINFO_DOWNLOAD no  
ENV REPO_UPDATES_DOWNLOAD no  
ENV REPO_UPDATES_SOURCE_DOWNLOAD no  
ENV REPO_EXTRAS_DOWNLOAD no  
ENV REPO_EXTRAS_SOURCE_DOWNLOAD no  
ENV REPO_CENTOSPLUS_DOWNLOAD no  
ENV REPO_CENTOSPLUS_UPDATES_DOWNLOAD no  
ENV REPO_CR_DOWNLOAD no  
ENV REPO_FASTTRACK_DOWNLOAD no  
ENV REPO_EPEL_DOWNLOAD no  
ENV REPO_EPEL_SOURCE_DOWNLOAD no  
ENV REPO_EPEL_DEBUGINFO_DOWNLOAD no  
ENV REPO_C7_MEDIA_DOWNLOAD no  
ENV REPO_OPENSHIFT_ORIGIN_DOWNLOAD no  
ENV REPO_OPENSTACK_KILO_DOWNLOAD no  
ENV REPO_OPSTOOLS_RELEASE_DOWNLOAD no  
ENV REPO_SCLO_RH_DOWNLOAD no  
ENV REPO_SCLO_SCLO_DOWNLOAD no  
  
# Other download Variables  
ENV REPOSYNC_VERBOSE no  
ENV CREATEREPO_VERBOSE no  
ENV DELETE_LOCAL_PACKAGES no  
  
# Install:  
# external repositories files  
# dependencies for downloading and creating repos  
# + Cleaning  
RUN yum install -y \  
centos-release \  
epel-release \  
centos-release-openshift-origin \  
centos-release-openstack \  
centos-release-opstools \  
centos-release-scl-rh \  
centos-release-scl \  
yum-utils deltarpm createrepo \  
&& yum --enablerepo=* clean all \  
&& rm -rf /var/cache/yum  
  
COPY repo_downloader.sh /root/repo_downloader.sh  
  
RUN mkdir /opt/repos  
  
ENTRYPOINT ["/bin/bash", "/root/repo_downloader.sh"]  
  
CMD [""]  

