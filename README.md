# Roman Ten — portfolio

A one-page, static portfolio for applied AI and full-stack work. It leads with a WRS engineering case study and includes the flashcard fine-tuning project. The WRS details are checked against the public `ragskill` repository. The flashcard result is framed as a small 20-passage evaluation, not a general performance claim. No RAG quality or customer-impact benchmark is claimed.

The English version is served at `/`, with a complete Russian translation at `/ru/`. Both pages include an EN/RU switch and reciprocal `hreflang` metadata.

## Portfolio assistant

The first-screen assistant card keeps its designed introduction on initial load. Activating its question field mounts WRS site `46` inside the card body using the widget's on-demand inline, headerless, dark-theme options. The embed locks the portfolio's lime/slate palette and minimal preset, so changes to the site's general WRS appearance configuration do not restyle the portfolio. The assistant never becomes a floating bubble, and no API key is stored in the portfolio.

## VPS deployment

The static files in `dist/` are served by Nginx from an atomic release directory under `/var/www/portfolio`. The active release is selected through the `/var/www/portfolio/current` symlink, so a new version can be uploaded and verified before replacing the previous one.

The permanent server names are `tenroman.com` and `www.tenroman.com`; `portfolio.109-248-18-117.sslip.io` remains available as a temporary fallback. Their isolated Nginx block lives in `deploy/nginx-portfolio.conf`, so the existing VPS sites do not need to be modified. The root domain uses an `A` record pointing to `109.248.18.117`, and `www` uses a `CNAME` record pointing to `tenroman.com`. HTTPS is provided by a dedicated Let's Encrypt certificate with automatic renewal; HTTP and `www` redirect to the canonical `https://tenroman.com` URL.

`deploy/deploy-remote.sh` installs an uploaded `/tmp/portfolio-release.tar.gz` and `/tmp/portfolio.conf.new`, validates the complete Nginx configuration, and reloads Nginx only if validation succeeds.

## Content sources

- Flashcard evaluation: <https://huggingface.co/tenroman/qwen3-vl-8b-flashcard-qlora>
- Flashcard code: <https://github.com/xenostate/qwen-flashcard-qlora>
- WRS implementation: <https://github.com/xenostate/ragskill>
- Contact and identity: `Roman_Ten_Resume.docx`

## Before publishing content changes

Keep the downloadable resume in `dist/Roman_Ten_Resume.pdf` aligned with the current site copy. Recheck the flashcard result and model-card link after a new training and evaluation run. After publishing this copy, reindex the portfolio in WRS so the embedded assistant has current project information.
