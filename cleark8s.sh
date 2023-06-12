#!/bin/bash

for i in {100..150}; do ping -c 1 192.168.1.$i >/dev/null && echo "192.168.1.$i is UP" || echo "192.168.1.$i is DOWN"; done



Delete the Kubernetes packages:

csharp

sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni
sudo rm -rf /etc/kubernetes
sudo systemctl stop kubelet
sudo systemctl disable kubelet
sudo rm -rf /var/lib/kubelet
sudo rm -rf /var/lib/etcd
sudo rm -rf /var/lib/kubernetes
sudo rm -rf /usr/bin/kubeadm
sudo rm -rf /usr/bin/kubectl
sudo rm -rf /usr/bin/kubelet




apt-mark unhold kubelet && apt-get update && apt-get install -y kubelet=1.25.5-00 && apt-mark hold kubelet
systemctl restart kubelet