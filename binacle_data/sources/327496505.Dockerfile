FROM registry.svc.ci.openshift.org/openshift/release:golang-1.12 AS builder
WORKDIR /ingress-operator
COPY . .
RUN make build

FROM registry.svc.ci.openshift.org/openshift/origin-v4.0:base
COPY --from=builder /ingress-operator/ingress-operator /usr/bin/
COPY manifests /manifests
RUN useradd ingress-operator
USER ingress-operator
ENTRYPOINT ["/usr/bin/ingress-operator"]
LABEL io.openshift.release.operator true
LABEL io.k8s.display-name="OpenShift ingress-operator" \
      io.k8s.description="This is a component of OpenShift Container Platform and manages the lifecycle of ingress controller components." \
      maintainer="Dan Mace <dmace@redhat.com>"
