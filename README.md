# Notes

## Manual Commands

I am going through the motions of doing everything by hand before I make an attempt to automate the installation.

**Deploy the Single Node Cluster:** `curl -sfL https://get.k3s.io | sh -s - server --service-cidr 10.43.0.0/16 --cluster-cidr 10.44.0.0/16`

**Location of Default Kube Config**: `/etc/rancher/k3s/k3s.yaml`

**Install Kubernetes Dashboard**:

```
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard
```

**Access Dashboard:**

```
kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443
Dashboard will be available at:
  https://localhost:8443
```
