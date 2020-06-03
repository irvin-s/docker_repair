FROM quay.io/operator-framework/helm-operator:v0.8.1

# Required OpenShift Labels
LABEL name="Kubeturbo Operator" \
      vendor="Turbonomic" \
      version="v6.3.0" \
      release="1" \
      summary="This is the kubeturbo operator." \
      description="This operator will deploy an instance of kubeturbo." \
### Required labels above - recommended below
      url="http://www.turbonomic.com" \
      run='docker run -tdi --name ${NAME} turbonomic/kubeturbo-operator:6.3' \
      io.k8s.description="Turbonomic Workload Automation Platform simultaneously optimizes performance, compliance, and cost in real-time. Workloads are precisely resourced, automatically, to perform while satisfying business constraints.  " \
      io.k8s.display-name="Kubeturbo Operator" \
      io.openshift.expose-services="" \
      io.openshift.tags="turbonomic, Multicloud Container"

# Required Licenses
COPY licenses /licenses

COPY watches.yaml ${HOME}/watches.yaml
COPY helm-charts/ ${HOME}/helm-charts/
