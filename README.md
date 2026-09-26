# stenographer-releases

Published builds of Stenographer, a macOS app that records Claude Code session
activity. This repo holds release output only; the source lives elsewhere.

`scripts/release.py` in the Stenographer repo writes everything here. Don't
edit these files by hand.

| Path | What it is | Who reads it |
|---|---|---|
| GitHub Release `vX.Y.Z` | `Stenographer-X.Y.Z.pkg` (first install) and `Stenographer-X.Y.Z.zip` (Sparkle update) | people installing Stenographer, and Sparkle |
| `releases.json` | release metadata (schema 1), newest first | agenticstenographer.app `/downloads` |
| `appcast.xml` | EdDSA-signed Sparkle feed | agenticstenographer.app `/appcast.xml`, which installed apps poll |
| `notes/X.Y.Z.md` | release notes | `/downloads` and Sparkle's update dialog |

The website reads these files at request time, so publishing a release never
needs a site deploy. Installed apps poll `https://agenticstenographer.app/appcast.xml`,
never this repo directly. That way the storage can move without leaving
installed copies behind.
