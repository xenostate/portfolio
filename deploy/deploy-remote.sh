#!/usr/bin/env bash

set -euo pipefail

release_id="${1:?release id is required}"
release_dir="/var/www/portfolio/releases/${release_id}"
nginx_config="/etc/nginx/conf.d/portfolio.conf"

install -d -m 755 "${release_dir}"
tar -xzf /tmp/portfolio-release.tar.gz -C "${release_dir}"
find "${release_dir}" -type d -exec chmod 755 {} +
find "${release_dir}" -type f -exec chmod 644 {} +

install -d -m 755 /var/www/portfolio
ln -sfn "${release_dir}" /var/www/portfolio/current
install -m 644 /tmp/portfolio.conf.new "${nginx_config}"

if nginx -t; then
    systemctl reload nginx
else
    mv "${nginx_config}" /tmp/portfolio.conf.failed
    exit 1
fi

systemctl is-active nginx
curl -fsS \
    -H 'Host: portfolio.109-248-18-117.sslip.io' \
    http://127.0.0.1/ \
    | grep -m1 -E '<title>|<h1'
