#/bin/bash
ARGS="--kubeconfig=/home/ramius/kubernetes/kubeconfig.yaml 
--bind-address 0.0.0.0
--cluster-cidr 172.18.0.0/16
--proxy-mode iptables
"

SUDO=''
if [ `whoami` != 'root' ]; then
    SUDO=sudo
fi

#${SUDO} docker rm -f proxy || true
${SUDO} docker run --name proxy --privileged=true --net=host --pid=host \
-v /home/ramius/kubernetes/certificate_authority/ca:/etc/kubernetes/ssl \
-v /home/ramius/kubernetes:/home/ramius/kubernetes \
-v /lib/modules:/lib/modules \
gcr.io/google_containers/hyperkube:v1.10.2 \
/hyperkube proxy ${ARGS}

