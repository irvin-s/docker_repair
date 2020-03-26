FROM turbonomic/kubeturbo:6.4dev
COPY kubeturbo.debug ${APP_ROOT}/bin/kubeturbo
ADD dlv /usr/local/bin/dlv
EXPOSE 40000
ENTRYPOINT ["/usr/local/bin/dlv", "--listen=:40000", "--headless=true", "--api-version=2", "exec", "/opt/turbonomic/bin/kubeturbo", "--", "--turboconfig=/etc/kubeturbo/turbo.config", "--v=2", "--kubelet-https=true", "--kubelet-port=10250"]
