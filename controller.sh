#!/bin/bash
ARGS="--master=http://127.0.0.1:8080 \
--cluster-cidr=172.18.0.0/16 \
--allocate-node-cidrs=false \
--service-cluster-ip-range=172.18.0.0/16 \
--service-account-private-key-file=/etc/kubernetes/ssl/private/kubeapi.pineapple.no-ip.biz.key.pem \
--root-ca-file=/etc/kubernetes/ssl/certs/ca.cert.pem \
--leader-elect=true \
--root-ca-file=/etc/kubernetes/ssl/certs/ca.cert.pem \
--pod-eviction-timeout=0m30s \
--node-monitor-grace-period=0m16s \
--node-monitor-period=0m2s \
--flex-volume-plugin-dir=/etc/kubernetes/volumeplugins"


SUDO=''
if [ `whoami` != 'root' ]; then
    SUDO=sudo
fi

${SUDO} docker rm -f controller
${SUDO} docker run --name controller --net=host --pid=host -v /home/ramius/kubernetes/certificate_authority/ca:/etc/kubernetes/ssl \
gcr.io/google_containers/hyperkube:v1.10.2 \
/hyperkube controller-manager ${ARGS}

