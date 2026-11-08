# Business in a box

A ready-made OpenMausBot team that runs the core of a business.

| Bot | Role | Starts at |
|---|---|---|
| Atlas | Chief of Staff: priorities, morning brief, weekly report | Full access |
| Rel | Customers and partners (CRM, follow-ups) | Ask |
| Echo | Marketing, content, video briefs | Ask |
| Forge | Engineering: website, apps, repos | Full access |
| Ledger | Bookkeeping, invoices, month-end | Ask |
| Reel | Video production with OpenMontage | Ask |

The approval levels are suggestions. OpenMausBot records them and starts every imported bot at your default level, so set them yourself after import.

## Add it

1. In OpenMausBot, open **Templates → Import** and choose `business-in-a-box-1.0.0.openmaus.json`.
2. Skills arrive switched off and routines arrive paused. Read each skill, then switch it on in each bot's **Skills** settings.
3. Fill in `memory/business.md` in Atlas's notes (Atlas asks you if you don't).
4. Turn on the routines you want: Morning brief (weekdays 7:37), Weekly review (Mondays 8:43) and Month-end close (the 1st, 9:17), all Vancouver time.
5. Connect Gmail, Google Drive and GitHub if you want the bots to use them.

## Video with OpenMontage

Reel runs [OpenMontage](https://github.com/publishedarts-oss/openmontage) as a separate, unmodified program on its own computer, following that repo's `AGENT_GUIDE.md`. OpenMontage is AGPL-3.0, so it is kept out of this team and out of the business's own code. Only the instructions for using it live here.

Reel's computer needs Python 3.10+, FFmpeg and Node. Run `make demo` in the OpenMontage folder to test a setup with no API keys.

## Next release

Change the team in the app, then use **Share department…** to save the next release (1.0.1, …). It keeps the same package id and bot keys.
