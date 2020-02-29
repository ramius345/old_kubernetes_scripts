#!/bin/bash
ARGS="--bind-address=0.0.0.0
--etcd-servers=https://greengrape.pineapple.no-ip.biz:2379
--allow-privileged=true
--service-cluster-ip-range=172.18.0.0/16
--secure-port=443
--advertise-address=192.168.1.253
--admission-control=NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,ResourceQuota
--tls-cert-file=/etc/kubernetes/ssl/certs/kubeapi.pineapple.no-ip.biz.cert.pem
--tls-private-key-file=/etc/kubernetes/ssl/private/kubeapi.pineapple.no-ip.biz.key.pem
--client-ca-file=/etc/kubernetes/ssl/certs/ca.cert.pem
--service-account-key-file=/etc/kubernetes/ssl/private/kubeapi.pineapple.no-ip.biz.key.pem
--runtime-config=extensions/v1beta1/networkpolicies=true
--runtime-config=batch/v2alpha1=true
--anonymous-auth=true
--authorization-mode=AlwaysAllow
--etcd-cafile=/etc/kubernetes/ssl/certs/ca.cert.pem
--etcd-keyfile=/etc/kubernetes/ssl/private/greengrape.pineapple.no-ip.biz.key.pem
--etcd-certfile=/etc/kubernetes/ssl/certs/greengrape.pineapple.no-ip.biz.cert.pem"

SUDO=''
if [ `whoami` != 'root' ]; then
    SUDO=sudo
fi

${SUDO} docker rm -f apiserver
${SUDO} docker run --name apiserver --net=host --pid=host -v /home/ramius/kubernetes/certificate_authority/ca:/etc/kubernetes/ssl gcr.io/google_containers/hyperkube:v1.10.2 /hyperkube apiserver ${ARGS}
