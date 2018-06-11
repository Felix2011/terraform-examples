[Unit]
Description=Preload httpd docker image

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStartPre=/usr/bin/docker pull httpd
ExecStart=/usr/bin/docker run -dit --name httpd -p 80:80 httpd

[Install]
WantedBy=multi-user.target
