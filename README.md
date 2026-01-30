### About
Reproducer scripts for https://github.com/kubernetes-sigs/kueue/issues/8095 using [kube-burner-ocp](https://github.com/kube-burner/kube-burner-ocp). 
Configures Kueue with 2 ResourceFlavors (CPU and GPU) and starts 100 jobs running on GPU and 1000 jobs running on CPU.

### Pre-requisites
1. OCP cluster with one regular worker node (e.g. m6i.2xlarge) and one worker node with GPU (e.g. g4dn.xlarge).
2. Install operators: cert-manager, NFD (+nfd-instance), NVIDIA GPU operator (+gpu-cluster-policy)
3. Deploy Kueue, e.g. 'kubectl apply --server-side -f https://github.com/kubernetes-sigs/kueue/releases/download/v0.16.0/manifests.yaml'
4. Configure OCP monitoring for upstream Kueue by applying [kueue-prometheus-setup.yml](smoke-test/kueue-prometheus-setup.yml) and [configmap-enable-user-workload.yml](smoke-test/configmap-enable-user-workload.yml).
5. Create a token secret for prometheus-user-workload: 'kubectl create secret generic prometheus-user-workload-token -n kueue-system --from-literal=token="$(oc create token prometheus-user-workload -n openshift-user-workload-monitoring --duration=8760h)"'

### Run the benchmark
./kube-burner/run.sh
