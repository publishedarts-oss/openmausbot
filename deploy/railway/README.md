# Railway

`railway.json` at the repository root builds `deploy/railway/Dockerfile`: the published OpenMausBot image with Claude Code, Codex and Grok Build, plus a Caddy edge on Railway's `$PORT`.

## Set up

1. In Railway: **New project → Deploy from GitHub repo**, choose this repository and the branch that holds `railway.json`.
2. On the service, add a **Volume** mounted at `/data`. Without it, bots, chats and sign-ins are lost on every deploy.
3. **Settings → Networking → Generate Domain**. If Railway asks for a port, use `8080`.
4. Wait for the deploy to turn green (the first build takes a few minutes).
5. Open the service's shell (**⋯ → SSH**, or `railway ssh` from a computer) and sign in the engines you use:
   - Claude: `claude`, then follow the sign-in link.
   - Codex: `codex login --device-auth`
   - Grok: `grok` (or sign in later from the app's engine setup).
6. In the same shell: `openmausbot pair --label phone`, then scan the code with the MausBot phone app or open the link.

`OMB_PUBLIC_URL` is set from Railway's domain automatically. To use a custom domain, set `OMB_PUBLIC_URL` and `OMB_WEBHOOK_PUBLIC_URL` to `https://your.domain` in the service's variables.

Keep one replica: the data volume can only be used by one server at a time.

## Back up

The whole state lives in the `/data` volume (OpenMausBot's data and the engines' sign-ins). Use Railway's volume backups.
