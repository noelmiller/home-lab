# Home Lab

## What is this?

This documents the scripts I use to deploy a single node K3S cluster in my home lab.

## Manual Commands

The default location is `/opt/local-path-provisioner`

This will put all of the storage you use on the disk that you have root on. In my case, I want to mount a larger disk to that location for my volumes.

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

**IMPORANT: The storage should be configured before you move on to the automated scripts**

## Automated Script

First, pull down the git repo onto the node you want to install k3s on.

Next, cd into the directory and run `cd cluster-system && ./prepare-cluster.sh`

After you have done the prep work, just run `./cluster-setup.sh`

It will ask for an email address and an API token for Cloudflare. You will need to add permissions to your domain in order to allow the challenge to work.

<https://cert-manager.io/docs/configuration/acme/dns01/cloudflare/>

Everything should complete successfully and now it's time to enjoy the cluster!
