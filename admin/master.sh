#!/bin/bash

# chrono @ 2022-04

# https://kubernetes.io/zh/docs/reference/setup-tools/kubeadm/kubeadm-init/

# init k8s
# --apiserver-advertise-address=192.168.10.210
# 还是需要强行指定 下image-repository
sudo kubeadm init \
    --pod-network-cidr=10.10.0.0/16 \
    --image-repository=registry.aliyuncs.com/google_containers \
    --kubernetes-version=v1.23.3 \
    --v=5

# enable kubectl
# tb@tb:~$ kubectl get node
# The connection to the server localhost:8080 was refused - did you specify the right host or port?

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
echo 'export KUBECONFIG=$HOME/admin.conf' >> $HOME/.bashrc


# check
kubectl version
kubectl get node

# kubeadm join 192.168.10.210:6443 --token tlx8h6.nqq9ae0x6n311ur2 \
#   --discovery-token-ca-cert-hash sha256:3ad1e8a51484ec125e2394f03eb3c0429f467a88b432a9408faef6d00f197e87
# 如果忘了了master的join 信息也没关系，可以执行 
# kubeadm token create --print-join-command
# 如果没有信息，或者过期了，可以执行
# kubeadm token create
# get join token
# kubeadm token list
# kubeadm token create --print-join-command
# openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'


