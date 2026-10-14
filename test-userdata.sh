#!/bin/bash

set -e
######
### Main Bootstrap
#####

APP_DEST="/usr/local/bin"
APP_USER="fakeServiceUser"
UNIT_NAME="statementService"

ENV_LISTEN_ADDR="0.0.0.0:9093"
ENV_NAME="statement-svc"
ENV_MESSAGE="Hello Cloud Bank | Retail Banking | statement-svc"
#ENV_UPSTREAM_URIS="http://unkown:9093"

###
if ! id -u "$APP_USER" > /dev/null 2>&1; then
   useradd -r -M -s /sbin/nologin "$APP_USER"
fi

## Download fake-service
dnf install -y unzip

wget -qO /tmp/fake_service.zip https://github.com/nicholasjackson/fake-service/releases/download/v0.26.2/fake_service_linux_amd64.zip
unzip -o /tmp/fake_service.zip -d "$APP_DEST"
rm -f /tmp/fake_service.zip
chmod +x "$APP_DEST/fake-service"

cat <<EOF > "/etc/systemd/system/${UNIT_NAME}.service"
[Unit]
Description=Fake Service App 

[Service]
Type=simple
User=$APP_USER
ExecStart=$APP_DEST/fake-service
Restart=on-failure
Environment=LISTEN_ADDR="$ENV_LISTEN_ADDR"
Environment=NAME="$ENV_NAME"
Environment=MESSAGE="$ENV_MESSAGE"
#Environment=UPSTREAM_URIS="$ENV_UPSTREAM_URIS"


[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable ${UNIT_NAME}.service
systemctl start ${UNIT_NAME}.service