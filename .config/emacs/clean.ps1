(".\.cache\", ".\.lsp-session-v1", ".\auto-save-list\", ".\backups\", ".\eln-cache\", ".\elpaca\", ".\projectile-bookmarks.eld", ".\recentf") | ForEach-Object { Remove-Item -Force -Recurse $_ }
