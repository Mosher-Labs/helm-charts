# Mosher Labs Helm Charts - Project Memory

This file contains persistent context for Claude Code sessions on this project.
It will be automatically loaded at the start of every session.

## Project Overview

This is a Helm charts monorepo for custom Kubernetes applications. Currently,
it contains template/example charts. The primary deployment mechanism for the
homelab uses **OSS Helm charts**, not custom charts from this repo.

**Key Details:**

- **Purpose:** Custom Helm chart development and templates
- **Current Status:** Template repository with hello-world example
- **Deployment:** Charts deployed via `helm upgrade --install` or ArgoCD
- **Target Cluster:** 3-node k3s homelab (see homelab-gitops repo)

## Repository Structure

```
helm-charts/
├── .github/               # GitHub Actions workflows
├── hello-world/           # Example/template chart
│   ├── Chart.yaml
│   ├── values.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       └── ingress.yaml
├── .helmignore
├── .pre-commit-config.yaml
├── .yamllint
└── README.md
```

## Important Context

### This Repo is NOT Primary Source

**CRITICAL:** The homelab cluster primarily uses **well-maintained OSS Helm charts**
from external repositories, NOT custom charts from this repo.

Examples of OSS charts we use:

- PiHole: `mojo2600.github.io/pihole-kubernetes`
- MetalLB: `metallb.github.io/metallb`
- Sealed Secrets: `bitnami-labs.github.io/sealed-secrets`
- Home Assistant: `charts.gabe565.com` (gabe565/home-assistant)

**Purpose of this repo:**

- Template for creating new Helm charts
- Custom charts when no suitable OSS alternative exists
- Learning/experimentation with Helm chart development

### Current Charts

#### hello-world

A basic template chart demonstrating Helm best practices:

- Deployment with configurable replicas
- Service (ClusterIP by default)
- Ingress (optional, disabled by default)
- Configurable image, resources, nodeSelector, tolerations, affinity
- Values files for different environments

**Usage:**

```bash
helm upgrade --install hello-world ./hello-world
helm status hello-world
```

## Development Workflows

### Creating a New Chart

```bash
# Option 1: Use hello-world as template
cp -r hello-world new-chart-name
cd new-chart-name
# Update Chart.yaml, values.yaml, templates/

# Option 2: Generate from scratch
helm create new-chart-name
```

### Testing Charts Locally

```bash
# Lint the chart
helm lint ./chart-name

# Dry-run to see generated YAML
helm install --dry-run --debug chart-name ./chart-name

# Template with custom values
helm template chart-name ./chart-name -f custom-values.yaml

# Install to cluster
helm upgrade --install release-name ./chart-name
```

### Packaging Charts

```bash
# Create .tgz package
helm package chart-name

# Update index (for chart repository)
helm repo index .
```

## Cluster Integration

### Kubeconfig Setup

```bash
# Copy from k3s server
scp -i $HOME/.ssh/ansible_key ansible@<SERVER_IP>:/etc/rancher/k3s/k3s.yaml $HOME/k3s.yaml

# Update server IP
sed -i '' 's/127.0.0.1/<SERVER_IP>/g' $HOME/k3s.yaml
chmod 600 $HOME/k3s.yaml

# Use kubeconfig
export KUBECONFIG=$HOME/k3s.yaml

# Update /etc/hosts for local access
sudo sed -i '' '/mosher-labs.local/d' /etc/hosts
echo "<SERVER_IP> mosher-labs.local" | sudo tee -a /etc/hosts
```

### Deploying to Homelab

**Option 1: Direct Helm Install**

```bash
export KUBECONFIG=$HOME/k3s.yaml
helm upgrade --install release-name ./chart-name --namespace namespace --create-namespace
```

**Option 2: ArgoCD (Preferred)**

Create ArgoCD Application in homelab-gitops repo:

```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: app-name
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/Mosher-Labs/helm-charts.git
    path: chart-name
    targetRevision: main
  destination:
    server: https://kubernetes.default.svc
    namespace: app-namespace
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

## Helm Best Practices

### Chart.yaml

- Use semantic versioning (major.minor.patch)
- Increment `version` when chart changes
- Update `appVersion` when application version changes
- Include description, type (application/library), maintainers

### values.yaml

- Document all values with comments
- Provide sensible defaults
- Group related values
- Use camelCase for keys
- Keep flat when possible (avoid deep nesting)

### Templates

- Use `{{ .Chart.Name }}-{{ .Release.Name }}` for resource names
- Add labels: app.kubernetes.io/name, app.kubernetes.io/instance
- Make everything configurable via values
- Use `_helpers.tpl` for common template functions
- Add resource limits/requests
- Include probes (liveness, readiness) when applicable

### Security

- Run as non-root when possible
- Set securityContext
- Use read-only root filesystem if possible
- Define resource limits
- Use NetworkPolicies (when needed)

## Pre-commit Hooks

This repository uses pre-commit hooks for quality control.

**Installed hooks:**

- check-yaml
- yamllint
- helm-lint (if available)
- markdownlint
- trailing whitespace, end-of-file
- Conventional Commits format

**Setup:**

```bash
pre-commit install
pre-commit run -a --all-files
pre-commit autoupdate
```

## Cloudflare Tunnels (Optional)

The hello-world chart includes Cloudflare tunnel integration for external access.

**Setup:**

1. Create tunnel at https://one.dash.cloudflare.com
2. Note the TOKEN
3. Create Kubernetes secret:

   ```bash
   kubectl create secret generic cloudflared-credentials \
     --from-literal=tunnel-token=<YOUR_TOKEN> \
     --namespace default
   ```

4. Enable in values.yaml or via --set

## Common Commands

```bash
# List installed releases
helm list -A

# Get release values
helm get values release-name

# Upgrade with new values
helm upgrade release-name ./chart-name -f new-values.yaml

# Rollback to previous version
helm rollback release-name

# Uninstall release
helm uninstall release-name
```

## Related Repositories

- **homelab-gitops:** https://github.com/Mosher-Labs/homelab-gitops
  - ArgoCD applications
  - Primary deployment repo
  - Uses OSS Helm charts (not this repo)

- **ansible-node-setup:** Ansible playbooks for k3s cluster provisioning

## Important Notes

### When Working on This Repo

1. **Prefer OSS charts** - Only create custom charts when no good alternative exists
2. **Follow Helm best practices** - Use the hello-world chart as reference
3. **Test locally** with `helm lint` and `--dry-run` before deploying
4. **Document values** - Every value should have a comment explaining it
5. **Version properly** - Semantic versioning for both chart and app
6. **Create CLAUDE.md** in any new repo or sub-project

### Chart Distribution

Currently, charts are used directly from this repo (not published to a chart registry).

**To publish to a chart repository (future):**

1. Package charts: `helm package chart-name`
2. Create index: `helm repo index .`
3. Host on GitHub Pages, S3, or chart registry
4. Add repo: `helm repo add mosher-labs <URL>`

## References

- @README.md - Repository overview and quick start
- Helm Docs: https://helm.sh/docs/
- Helm Best Practices: https://helm.sh/docs/chart_best_practices/
- ArtifactHub: https://artifacthub.io/ (find OSS charts)

---

**Last Updated:** 2025-11-14

This file should be updated whenever:

- New charts are added
- Best practices change
- Deployment patterns change
- Important context is discovered
