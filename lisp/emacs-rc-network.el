(when (string-match "work.*" (system-name))
  (setq url-proxy-services
        '(("no_proxy" . "^\\(localhost\\|0.*\\)")
          ("http" . "127.0.0.1:8118")
          ("https" . "127.0.0.1:8118"))))
