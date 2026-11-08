#!/bin/bash
set -euo pipefail

if [ "$(id -u)" = 0 ]; then
  mkdir -p /data
  # Railway mounts volumes owned by root.
  if [ "$(stat -c %U /data)" != maus ]; then chown -R maus:maus /data; fi
  exec setpriv --reuid=maus --regid=maus --init-groups "$0" "$@"
fi

export HOME=/data
if [ -n "${RAILWAY_PUBLIC_DOMAIN:-}" ]; then
  export OMB_PUBLIC_URL="${OMB_PUBLIC_URL:-https://$RAILWAY_PUBLIC_DOMAIN}"
  export OMB_WEBHOOK_PUBLIC_URL="${OMB_WEBHOOK_PUBLIC_URL:-https://$RAILWAY_PUBLIC_DOMAIN}"
fi
export PORT="${PORT:-8080}"

caddy run --config /etc/openmausbot/Caddyfile --adapter caddyfile &
cd /app
node dist-server/server-launcher.js &

# Exit when either process stops, so Railway restarts the container.
wait -n
exit $?
