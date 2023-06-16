#!/bin/bash

CUSTOMER=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace | awk -F'-' '{print $1}') && \
    find /opt/keycloak/themes/Sofvie*/email/messages/ \
    -type f -name 'messages_*.properties' \
    -exec sed -i "s#https://devcore-resources.sofvie.com/img/sofvieWhite.png#https://${CUSTOMER}-images.sofvie.com/client_logo/logo.png#g" {} \;
