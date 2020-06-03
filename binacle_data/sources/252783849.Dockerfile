FROM binhnv/base  
MAINTAINER "Binh Van Nguyen<binhnv80@gamil.com>"  
EXPOSE 88 750  
ENV KRB_MASTER_DB_PASS="root" \  
KRB_MASTER_KEY_NAME="masterkey" \  
KRB_ADMIN_USER="root" \  
KRB_ADMIN_PASS="root" \  
KRB_KEYTAB_DIR="/etc/security/keytabs" \  
KRB_USER_PRINCIPALS="" \  
KRB_SERVICE_PRINCIPALS="" \  
KRB_SERVICE_NAME="kerberos"  
ENV KRB_SERVICE_KEYTAB_FILE="${KRB_KEYTAB_DIR}/services.keytab"  
# A volume for keytab files to share them to clients  
VOLUME ["${KRB_KEYTAB_DIR}"]  
  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \  
krb5-kdc \  
krb5-admin-server \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY templates ${MY_TEMPLATE_DIR}  
COPY scripts/startup ${MY_STARTUP_DIR}  
COPY scripts/init ${MY_INIT_DIR}  
COPY services ${MY_SERVICE_DIR}  

