#!/bin/bash -e

set -e
set -o pipefail

KUBE_BURNER_VERSION=1.10.1
KUBE_DIR=${KUBE_DIR:-/tmp}
OS=$(uname -s)
HARDWARE=$(uname -m)
KUBE_BURNER_URL="https://github.com/kube-burner/kube-burner-ocp/releases/download/v${KUBE_BURNER_VERSION}/kube-burner-ocp-V${KUBE_BURNER_VERSION}-${OS}-${HARDWARE}.tar.gz"
THANOS_HOST="$(oc get route thanos-querier -n openshift-monitoring -o jsonpath='https://{.spec.host}')"
TOKEN=$(oc create token -n openshift-monitoring prometheus-k8s)

if [[ ! -f /tmp/kube-burner-ocp ]]; then
   curl --fail --retry 8 --retry-all-errors -sS -L "${KUBE_BURNER_URL}" | tar -xzC "${KUBE_DIR}/" kube-burner-ocp
fi

export THANOS_HOST TOKEN

${KUBE_DIR}/kube-burner-ocp init -c config.yml --metrics-endpoint=metrics-endpoint.yml
exit $?