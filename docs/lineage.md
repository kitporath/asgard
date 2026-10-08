# Platform lineage

```
Valhalla          Asgard                 KWS                    Products
(lab k3s-class) -> (enterprise rack) -> (private AI cloud) -> (Hirdforge, ...)
   learning           completed            completed            separate public repos
```

| Generation | Character | Portfolio repo |
|------------|-----------|----------------|
| Valhalla | Small hardware, early K8s, 1G, manual lessons | Mention only |
| **Asgard** | Enterprise gear, 10G, finished platform shape | **This repo** |
| **KWS** | Full private AI cloud (GitOps, SSO, Vault, GPU inference, agent ops) | [kws](https://github.com/sovereignty-labs/kws) |
| Products | Hirdforge, the multi-agent platform. Anvil, the old llama.cpp wrapper, is deprecated. | Project-owned GitHub |

**Interview line:** Asgard is where "real platform" became real; KWS is the AI-cloud
completion; products prove agent and inference layers on top.
