# Architecture (redacted)

## Intent

Provide a durable enterprise-class private platform: compute virtualization,
Kubernetes, storage, networking, and GitOps — suitable for running serious
workloads (including later AI product stacks) without depending on public cloud.

## Building blocks (roles)

| Role | Responsibility |
|------|----------------|
| Hypervisor hosts | KVM workloads, platform VMs |
| Kubernetes control plane | API/scheduler/etcd HA as designed for the generation |
| Workers | Application and platform add-ons |
| GPU nodes | Inference / heavy compute (when attached) |
| GitOps controllers | Desired state from git |
| Edge / ingress | North-south entry (implementation private) |
| Storage | Replicated block and/or local paths per workload class |

## What Asgard is not

- Not the full private-AI product story (that is **KWS** + product repos)
- Not a public mirror of every NetworkPolicy and sealed secret

## Diagram (logical)

```
[ Enterprise hosts / 10G fabric ]
        |
        +-- Hypervisor pool (VMs for platform services)
        |
        +-- Kubernetes (Talos-class path)
                +-- GitOps (app-of-apps)
                +-- CNI + network policy
                +-- Workloads (platform + products)
```
