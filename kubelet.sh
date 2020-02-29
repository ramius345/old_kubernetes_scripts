#!/bin/bash
ARGS="--kubeconfig=/home/ramius/kubernetes/kubeconfig_kubelet.yaml
--register-node=false
--allow-privileged=true
--cluster_dns=172.18.1.254
--cluster_domain=cluster.local
--cadvisor-port=0
--register-node
--fail-swap-on=false
--container-runtime docker
--network-plugin=cni
--cni-bin-dir=/opt/cni/bin
--cni-conf-dir=/etc/cni/net.d
--cgroup-driver=cgroupfs
--volume-plugin-dir=/etc/kubernetes/volumeplugins
--enable-controller-attach-detach=false
"

#--pod-cidr=172.17.1.0/24
#--cgroup-driver=systemd

sudo docker rm -f kubelet
sudo mkdir -p /var/lib/kubelet
sudo mount --bind /var/lib/kubelet /var/lib/kubelet
sudo mount --make-shared /var/lib/kubelet
sudo docker run \
--name kubelet \
--net=host \
--pid=host \
--privileged=true \
-v /dev:/dev \
-v /sys:/sys:ro \
-v /var/run:/var/run:rw \
-v /var/lib/docker/:/var/lib/docker:rw \
-v /var/lib/kubelet/:/var/lib/kubelet:shared \
-v /srv/kubernetes:/srv/kubernetes:ro \
-v /etc/kubernetes:/etc/kubernetes:ro \
-v /opt/cni/bin:/opt/cni/bin \
-v /etc/cni/net.d:/etc/cni/net.d \
-v /var/lib/calico:/var/lib/calico \
-v /home/ramius/:/home/ramius/ \
-v /var/run:/var/run:rw \
-v /sys/fs/cgroup:/sys/fs/cgroup:rw \
gcr.io/google_containers/hyperkube:v1.10.2 \
/hyperkube kubelet ${ARGS}
