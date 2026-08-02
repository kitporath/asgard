# Asgard — Enterprise Platform Generation (portfolio)

**Curated public repository.** Architecture and decisions for **Asgard** — the
finished enterprise-class private platform generation that precedes and supports
later work (KWS judgment lineage; production host for product workloads such as
Hirdforge).

This is **not** a dump of live GitOps or inventory. Operational trees stay private.

| | |
|--|--|
| **Role** | Sole architect & operator |
| **Status** | Completed enterprise platform generation |
| **Org** | [Sovereignty Labs](https://github.com/sovereignty-labs) |
| **Related** | [KWS](https://github.com/sovereignty-labs/kws) (private AI cloud) · product repos publish separately |

## What Asgard is

The generation where the rack and platform stopped being a toy lab:

- Enterprise-class hardware and **10G** networking
- Hypervisor layer (Proxmox-class) and modern Kubernetes path (Talos-class lineage)
- Platform services operated with GitOps discipline
- Foundation for subsequent **KWS** design judgment and a live home for agent product workloads

Earlier lab generation (**Valhalla**: small form-factor k3s-style learning cluster)
taught the painful lessons; Asgard is the completed "build it like a platform team"
estate.

## How it was built

Manual-heavy construction with AI guidance on implementation — **architecture and
tradeoffs owned by the operator.** That judgment carried forward into KWS (every
major primitive decided from experience, not invented by an agent).

## Start here

| Doc | Contents |
|-----|----------|
| [docs/architecture.md](docs/architecture.md) | Platform shape (roles only) |
| [docs/decisions.md](docs/decisions.md) | Why this generation exists |
| [docs/lineage.md](docs/lineage.md) | Valhalla -> Asgard -> KWS -> products |
| [docs/incidents.md](docs/incidents.md) | What went wrong, what was caught before it went wrong |
| [patterns/](patterns/) | Example-only sketches |
| [SANITIZATION.md](SANITIZATION.md) | What never ships here |

## Stack (representative)

Proxmox/KVM · Talos-class Kubernetes · Cilium · GitOps (ArgoCD) · LINSTOR-class
storage patterns · enterprise NIC/10G fabric · platform add-ons as needed for
workloads

## License

MIT — see [LICENSE](LICENSE). Examples are illustrative only.
