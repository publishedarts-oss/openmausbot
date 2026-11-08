# OpenMausBot on Railway: the published server image plus a Caddy edge on
# Railway's $PORT, because the server itself only listens on 127.0.0.1.
ARG BASE_IMAGE=ghcr.io/milind-soni/openmausbot:latest

FROM caddy:2.10.2 AS edge
# A plain copy drops the official binary's file capability, which an
# unprivileged user cannot exec under no-new-privileges.
RUN cp /usr/bin/caddy /caddy

FROM ${BASE_IMAGE}
USER root
COPY --from=edge /caddy /usr/local/bin/caddy
ARG ENGINES="@anthropic-ai/claude-code @openai/codex"
RUN if [ -n "$ENGINES" ]; then npm install -g $ENGINES; fi
# Grok Build, pinned and installed as in deploy/local/Dockerfile. GROK_VERSION= leaves it out.
ARG GROK_VERSION=1.0.41
RUN if [ -n "$GROK_VERSION" ]; then \
      mkdir -p /tmp/grok-install \
      && curl -fsSL https://x.ai/cli/install.sh -o /tmp/grok-install/install.sh \
      && HOME=/tmp/grok-install PATH="/tmp/grok-install/.grok/bin:$PATH" bash /tmp/grok-install/install.sh "$GROK_VERSION" \
      && install -m 0755 "$(readlink -f /tmp/grok-install/.grok/bin/grok)" /usr/local/bin/grok \
      && HOME=/tmp/grok-install grok --version | grep -qF "grok $GROK_VERSION " \
      && rm -rf /tmp/grok-install; \
    fi
COPY deploy/railway/Caddyfile /etc/openmausbot/Caddyfile
COPY --chmod=0755 deploy/railway/start.sh /usr/local/bin/openmausbot-railway
ENV OMB_PORT=8799 \
    OMB_WEBHOOK_PORT=8800 \
    OMB_CLI_PREFIX="openmausbot"
# Starts as root only to take ownership of Railway's root-owned volume, then
# drops to the maus user before anything else runs.
CMD ["/usr/local/bin/openmausbot-railway"]
