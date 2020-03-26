FROM  {{ docker_repo_url }}/{{ docker_repo_lib }}/{{ base_app }}:{{ base_app_tag }}

COPY CusDeploy /SETUP/Cus

RUN /SETUP/bin/applyCustomization.sh
