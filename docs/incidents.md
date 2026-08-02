# Incident narratives (redacted)

Asgard's operational record. Written the way I'd want to read it: what happened, what I
did, and what I got wrong.

Technical substance retained; hostnames, addresses and site-specific identifiers removed —
see [`../SANITIZATION.md`](../SANITIZATION.md). Hosts appear by role rather than name.

---

## 1. The redundancy that existed only on the dashboard

**Found by looking, not by failing. That is the whole point of it.**

**Situation.** Asgard was running real production work across eight hosts — a three-node
hypervisor cluster carrying a ten-node Kubernetes cluster (six control-plane, four
workers), three bare-metal inference servers, a router, and a bastion. Everything reported
healthy.

I had never verified that. So I ran a full read-only census of all eight hosts, the
storage and VM-placement map, and live Kubernetes, etcd and distributed-storage state, and
wrote down what was actually there rather than what the documentation claimed.

**What the census found.** The most valuable data on the platform — the knowledge
service's database, the Git server's database, and the Git repositories themselves — had
**no genuine redundancy and no working backup**, while the storage layer reported it
triple-replicated and healthy.

The replication was real at the Kubernetes layer and an illusion at the physical layer.
Every worker node's disk was a file on one hypervisor's single RAID array, so all three
"replicas" of every volume lived on **one physical device**.

From the audit, verbatim:

> The redundancy is healthy on the dashboard and absent in reality.
>
> This is the worst category of risk: catastrophic, total, and invisible.

It compounded. There was no working backup — the backup server had been orphaned when its
storage was removed during an earlier migration — so the only backup in existence was a
single etcd snapshot I took during the census itself. Also unprotected: the Sealed Secrets
controller key, whose loss would have made every encrypted secret in the cluster
permanently unrecoverable.

**Three concentrations, each of which turned an ordinary failure into a cluster-wide one:**

- One hypervisor's single RAID array backed nearly every VM on **two** hosts, served over
  the network. Losing the array — or the network path to it — stopped the cluster.
- A second hypervisor carried **three of four etcd members and the only bastion**. Losing
  it meant losing quorum and administrative access in the same moment. That host was also
  **the one with the failing drive**, already slated for removal.
- The bastion VM lived on that failing host with its disk on the RAID array — it depended
  on the two most fragile machines at once.

**And the observability gap that let it hide.** No metrics, no log aggregation. A
documentation service had crash-looped **over ten thousand times across thirteen days**
before anyone noticed. The drift-detection agent that did exist produced partly fabricated
output and could not see the Kubernetes layer at all.

**What I did.** The audit's own conclusion set the order of work, and the capacity to fix
it was already installed and idle — one hypervisor was running at about 4% memory use with
hundreds of gigabytes of free fast storage:

1. **Real data protection first**, independent of any migration — application-consistent
   dumps of both databases, a repository export, the Sealed Secrets key, and scheduled
   etcd snapshots. Stop the bleeding while the structural fix is in flight.
2. **Break the single-array dependency** — move VM disks onto per-host NVMe so that
   "replicated" data lives on genuinely distinct physical media.
3. **Give the control plane and bastion a third home**, then evacuate the failing host
   before its drive was pulled.

**Result.** The concentration was dismantled: the Kubernetes cluster was consolidated onto
the idle hypervisor and the storage moved off the shared array, **with no data loss and no
rebuild**. The corrected inventory went into version control as the single source of
truth, replacing documentation that had drifted from reality.

**What it demonstrates.** The failure never happened, which is the point — this is the
operating doctrine applied *before* an outage rather than after. Green indicators are a
claim; a census against live state is a fact. The most dangerous finding here was hiding
behind the healthiest-looking dashboard on the platform.

It is also where the doctrine came from. Everything I have built since is shaped by having
seen "healthy, triple-replicated" mean "one disk away from total, silent loss."

---

## 2. A dead storage definition hanging the cluster on every poll

**Situation.** The hypervisor cluster suffered intermittent freezes, and every storage
status query hung for a long interval before returning.

**What I did.** Traced it during the census to a **storage definition for a deprecated
backend that had been removed months earlier**. It was still configured cluster-wide, and
the status daemon blocked on it at every poll — on every node.

**Result.** Removing the dead definition dropped storage queries from timing out to about
one second.

**What I got wrong, and said so at the time.** I recorded this as the probable cause of
the intermittent SSH freezes. It wasn't — the freezes continued afterwards. The audit
notes that plainly rather than quietly claiming the fix, and names the failing drive as
the remaining suspect. Fixing a real problem is not the same as fixing *the* problem, and
a record that conflates them is worse than no record.

---

## 3. Migration cruft as a standing risk

**Situation.** A half-finished migration off an earlier storage backend had left residue
throughout: orphaned VMs, dangling storage references pointing at definitions that no
longer existed, duplicate machine definitions, hundreds of unpruned branches, and
per-node storage configuration that had been applied inconsistently.

Separately, operational knowledge lived in three places that disagreed with each other
and with the machines.

**What I did.** Treated the documentation drift as the primary defect rather than a
tidiness problem. The census output became a committed inventory — hosts, GPUs, storage
and Kubernetes topology in version control — so that "what is true" has one location and
can be diffed against live state.

**What it demonstrates.** Cruft from an abandoned migration is not cosmetic; the dead
storage definition in the previous entry was exactly this, and it was degrading the whole
cluster silently. Documentation that disagrees with the machines is the same class of
defect as a monitoring gap: both let a system be wrong without anyone finding out.
