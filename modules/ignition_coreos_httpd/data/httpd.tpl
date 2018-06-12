[Unit]
Description=Preload httpd docker image

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStartPre=/usr/bin/docker pull httpd
ExecStart=/usr/bin/docker run -dit --name httpd -p 80:80 -v /var/docker/htdocs:/usr/local/apache2/htdocs/ httpd

[Install]
WantedBy=multi-user.target
