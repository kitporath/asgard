# Pattern: network policy mindset (example only)

Principle: default-deny where practical; allow only required identities
(service accounts / labels) to reach data stores and control APIs.

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-app-to-db
  namespace: example
spec:
  podSelector:
    matchLabels:
      app: example-db
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: example-api
      ports:
        - protocol: TCP
          port: 5432
```

Do not publish live Cilium policies that encode internal service meshes or
management networks.
