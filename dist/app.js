(() => {
  const year = document.getElementById("year");
  if (year) year.textContent = new Date().getFullYear();

  const config = window.PORTFOLIO_ASSISTANT || {};
  const mount = document.getElementById("assistant-mount");
  const status = document.getElementById("assistant-status");
  if (!mount || !status || !config.embedUrl) return;

  let url;
  try {
    url = new URL(config.embedUrl);
    if (url.protocol !== "https:") throw new Error("HTTPS is required");
  } catch {
    return;
  }

  const iframe = document.createElement("iframe");
  iframe.src = url.href;
  iframe.title = "Ask Ten Roman — portfolio assistant";
  iframe.loading = "lazy";
  iframe.referrerPolicy = "strict-origin-when-cross-origin";
  iframe.style.cssText = "display:block;width:100%;height:350px;border:0;background:transparent";
  mount.replaceChildren(iframe);
  mount.style.padding = "0";
  status.textContent = "ASSISTANT LIVE";
});
