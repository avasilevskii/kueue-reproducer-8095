### About
Reproducer scripts for https://github.com/kubernetes-sigs/kueue/issues/8095 using [kube-burner](https://github.com/kube-burner/kube-burner). 
Configures Kueue with 2 ResourceFlavors (CPU and GPU) and starts 100 jobs running on GPU and 1000 jobs running on CPU.

### Pre-requisites
1. OCP cluster with one regular worker node (e.g. m6i.2xlarge) and one worker node with GPU (e.g. g4dn.xlarge).
1. Install operators: cert-manager, NFD (+nfd-instance), NVIDIA GPU operator (+gpu-cluster-policy)
2. Deploy Kueue, e.g. `kubectl apply --server-side -f https://github.com/kubernetes-sigs/kueue/releases/download/v0.16.0/manifests.yaml`

### Run the benchmark
`METRICS=kueue-metrics.yml kube-burner init -c config.yml`
