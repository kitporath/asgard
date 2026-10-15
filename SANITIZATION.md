# Sanitization policy — `asgard` public repo

Curated portfolio extract. Not the operational GitOps monorepo.

## Never commit

- Live inventories (hosts, GPUs, disks with serials)
- Real IPs, VIPs, DNS zones, node nicknames
- Sealed secrets, registry credentials, tunnel tokens, kubeconfigs
- Full CNP/egress policies that encode internal service topology in attackable form
- Agent deployment manifests that expose internal URLs and credentials

## Always prefer

- Role diagrams and generation narrative
- Generic pattern sketches
- Cross-links to [kws](https://github.com/kitporath/kws) for AI-cloud detail

## Before every push

```bash
./scripts/check-redaction.sh
```

## Private source of truth

Live Asgard GitOps and inventory remain on private infrastructure git. Publish
here only after rewrite.
