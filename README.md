# Asgard — the generation where it stopped being a lab

Enterprise hardware, 10G fabric, a hypervisor layer and a modern Kubernetes path,
operated with GitOps discipline. The completed platform generation that precedes
[KWS](https://github.com/sovereignty-labs/kws) — and still the production host for
product workloads.

**Its most valuable artifact is an audit that found the platform one disk away from
total, silent loss.** Everything reported healthy. Storage reported triple-replicated.
Every "replica" of every volume turned out to live on a single physical device, and
the only backup in existence was a snapshot taken during the audit itself.

> The redundancy is healthy on the dashboard and absent in reality.
>
> This is the worst category of risk: catastrophic, total, and invisible.

Nothing failed. It was found by looking — which is the entire point, and where the
operating doctrine carried into KWS came from.

| | |
|--|--|
| **Role** | Sole architect & operator |
| **Status** | Completed · runs Hirdforge in production |
| **Lineage** | Valhalla (lab) → **Asgard** → [KWS](https://github.com/sovereignty-labs/kws) |

---

## Read these first

| | |
|--|--|
| **[docs/incidents.md](docs/incidents.md)** | The census that found the invisible single point of failure, a dead storage definition hanging the whole cluster on every poll, and a fix I recorded as wrong when it turned out not to be the cause. |
| **[docs/decisions.md](docs/decisions.md)** | Why this generation exists and what it was built to prove. |
| **[docs/lineage.md](docs/lineage.md)** | Valhalla → Asgard → KWS → products, and what each one taught the next. |

Also here: [architecture](docs/architecture.md) (roles only) ·
[patterns/](patterns/) (example sketches)

---

## What it was

The generation where the rack and the platform stopped being a toy:

- Enterprise-class hardware and **10G** networking
- Hypervisor layer (Proxmox-class) and a modern Kubernetes path (Talos-class lineage)
- Platform services run with GitOps discipline
- A live home for agent product workloads, not a demo

The earlier lab generation — **Valhalla**, a small-form-factor k3s cluster — taught the
painful lessons cheaply. Asgard is where they were applied properly.

## How it was built

Manual-heavy construction with AI guidance on implementation — **architecture and
tradeoffs owned by the operator.** That judgment carried directly into KWS: every major
primitive there was decided from experience here, not invented by an agent.

Worth noting the comparison, since it is unflattering in one direction: Asgard's
Talos-based cluster recovered from a full power loss **100% hands-off**, where KWS
needed deliberate manual gates. Both facts are recorded rather than the convenient one.

## Stack

Proxmox/KVM · Talos-class Kubernetes · Cilium · GitOps (ArgoCD) · LINSTOR-class
storage patterns · enterprise NIC / 10G fabric

---

## What this repository is

A **curated extract, not a mirror.** Architecture, decisions and incidents are public;
operational trees, inventories and secrets are not — see
[SANITIZATION.md](SANITIZATION.md). Hosts appear by role.

**Related** · [KWS](https://github.com/sovereignty-labs/kws) — the private AI cloud
that followed · [Sovereignty Labs](https://github.com/sovereignty-labs)

## License

MIT — see [LICENSE](LICENSE). Examples are illustrative only.
