# Notes

## Manual Commands

I am going through the motions of doing everything by hand before I make an attempt to automate the installation.

**Copy crictl.yaml**: `cp crictl.yaml /etc/crictl.yaml`
```
runtime-endpoint: unix:///var/run/containerd/containerd.sock
image-endpoint: unix:///var/run/containerd/containerd.sock
timeout: 2
debug: false
```

**Mount Storage to Default Location on Different Disk**:
- Create a systemd-mount file: `opt-local\\x2dpath\\x2dprovisioner.mount`
```
[Unit]
Description=Mount K3S Data LV

[Mount]
What=UUID=[YOUR_UUID_HERE]
Where=/opt/local-path-provisioner
Type=ext4
Options=defaults

[Install]
WantedBy=multi-user.target
```
- `systemctl enable --now opt-local\\x2dpath\\x2dprovisioner.mount`


**Deploy the Single Node Cluster:** `curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --service-cidr 10.43.0.0/16 --cluster-cidr 10.44.0.0/16 --disable traefik,metrics-server,local-storage --disable-helm-controller --write-kubeconfig-mode 644 sh" sh -`

**Deploy Local Storage** `kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.32/deploy/local-path-storage.yaml`

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
