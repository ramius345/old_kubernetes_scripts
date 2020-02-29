#!/bin/bash
ARGS="--master=http://127.0.0.1:8080 --leader-elect=true"

SUDO=''
if [ `whoami` != 'root' ]; then
    SUDO=sudo
fi

${SUDO} docker rm -f scheduler
${SUDO} docker run --name scheduler --net=host --pid=host -v /home/ramius/kubernetes/certificate_authority/ca:/etc/kubernetes/ssl \
gcr.io/google_containers/hyperkube:v1.10.2 \
/hyperkube scheduler ${ARGS}

