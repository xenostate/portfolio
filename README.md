# Ten Roman — portfolio

A one-page, static portfolio for applied AI and machine-learning work. Project numbers are sourced from the local XGBoost churn experiment and the published flashcard model card; WRS architecture is sourced from the local `ragskill` README. No RAG performance benchmark is claimed.

## Connect the portfolio assistant

The first-screen assistant area intentionally ships as a clearly labeled reserved space. To activate it, edit `dist/assistant-config.js` and set `embedUrl` to an HTTPS page that permits embedding and hosts your WRS-powered portfolio assistant. The portfolio will replace the placeholder with an iframe. Do not put API keys in this public JavaScript file.

If you prefer the existing WRS floating widget, follow the `ragskill` project's widget installation instructions instead. It creates a bubble, not an inline chat, so the top assistant panel would need a small UI adaptation.

## VPS deployment

The static files in `dist/` are served by Nginx from an atomic release directory under `/var/www/portfolio`. The active release is selected through the `/var/www/portfolio/current` symlink, so a new version can be uploaded and verified before replacing the previous one.

The temporary server name is `portfolio.109-248-18-117.sslip.io`. Its isolated Nginx block lives in `deploy/nginx-portfolio.conf`; the existing VPS sites do not need to be modified. When the permanent domain is ready, replace the `server_name`, point its `A` record to `109.248.18.117`, run `nginx -t`, reload Nginx, and request a TLS certificate with Certbot.

`deploy/deploy-remote.sh` installs an uploaded `/tmp/portfolio-release.tar.gz` and `/tmp/portfolio.conf.new`, validates the complete Nginx configuration, and reloads Nginx only if validation succeeds.

## Content sources

- Flashcard evaluation: <https://huggingface.co/tenroman/qwen3-vl-8b-flashcard-qlora>
- Flashcard code: <https://github.com/xenostate/qwen-flashcard-qlora>
- WRS design: local `ragskill/README.md`
- Churn evaluation: local `classic_ML/churn/artifacts/metrics.json`
- CS2 project: <https://github.com/xenostate/binaryclassificationcs2>

## Update before sharing widely

The site is a concise project portfolio. Add a preferred contact email and resume link if you want recruiters to contact you directly. Recheck the results and public project links when replacing the synthetic churn dataset or rerunning the model.
