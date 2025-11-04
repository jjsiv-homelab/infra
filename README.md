# To do

- PiHole
- external-dns
- kube-prometheus-stack
- Cilium GatewayAPI
- ClusterAPI (with KubeVirt infra & Talos bootstrap)
- KubeVirt
- vCluster
- Crossplane (for ArgoCD secrets and maybe others)
- CI/CD
- ArgoCD Hydrators (try PR https://github.com/argoproj/argo-cd/pull/24277)
- GitOps promoter or Kargo (or both)
- Keycloak (maybe)
- Cluster upgrades with clusters as cattle approach
- KEDA

# Tenant onboarding

Create Helm chart

```yaml
apiVersion: abc.com/v1alpha1
kind: Tenant
metadata:
  name: tenant-1
spec:
  techstack:
    language: Go
    stateless: true
```
