#!/bin/bash -xe

apt-get update
apt-get install -y nginx

systemctl enable nginx
systemctl start nginx