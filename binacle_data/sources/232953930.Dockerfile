FROM ciandt/php:acquia-latest

# define Docker image label information
LABEL com.ciandt.vendor="Custom Vendor"

# defines root user, to perform privileged operations
USER root
