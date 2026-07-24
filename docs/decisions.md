# Decisions

## Enterprise gear + 10G, not another mini-PC generation
**Chose:** Invest in rack-class hardware and networking once the lab path proved
the ideas.
**Rejected:** Scaling Valhalla-style mini nodes forever.
**Why:** Bandwidth, reliability, and operational realism for "platform team" work.

## Modern Kubernetes path (Talos-class lineage)
**Chose:** Immutable / API-driven node OS approach for K8s hosts where it fit.
**Rejected:** Hand-snowflaked node images as the long-term model.
**Why:** Reproducibility and reduced config drift.

## GitOps as the change boundary
**Chose:** Desired state in git; controllers reconcile; humans review diffs.
**Rejected:** SSH-and-hope as the primary change mechanism.
**Why:** Auditability and rollback.

## Keep product GitOps concerns separable from AI-cloud catalog
**Chose:** Clear boundaries so product deploys (e.g. agent platforms) and private
AI cloud catalogs do not become one inseparable ball of mud.
**Why:** Blast radius and portfolio clarity (public extracts stay coherent).
