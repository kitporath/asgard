# Pattern: GitOps boundary (example only)

```text
infrastructure/          # cluster add-ons (public extract would be tiny samples only)
  apps/                  # Application CRs
apps/                    # raw manifests consumed by apps
```

Public portfolio intentionally keeps this **thin**. Live trees contain secrets and
topology and must not be copied here.
