# helm-charts

![GitHub branch status](https://img.shields.io/github/checks-status/mosher-labs/helm-charts/main)
![GitHub Issues](https://img.shields.io/github/issues/mosher-labs/helm-charts)
![GitHub last commit](https://img.shields.io/github/last-commit/mosher-labs/helm-charts)
![GitHub repo size](https://img.shields.io/github/repo-size/mosher-labs/helm-charts)
![Libraries.io dependency status for GitHub repo](https://img.shields.io/librariesio/github/mosher-labs/helm-charts)
![GitHub License](https://img.shields.io/github/license/mosher-labs/helm-charts)
![GitHub Sponsors](https://img.shields.io/github/sponsors/mosher-labs)

## 🎩 Helm Charts Monorepo 🚢

Welcome to the Helm Charts monorepo! 🚀 This repository serves as a centralized
collection of Helm charts for deploying and managing Kubernetes applications. 🎯

### 🌟 Key Features

- 📦 A monorepo structure for managing multiple Helm charts in one place.
- 🛠️ Charts for a variety of use cases, from microservices to full-stack applications.
- 🔧 Easily customizable values and templates to fit diverse workloads.
- 📜 Follows Helm best practices for scalability, consistency, and maintainability.

### ✨ Perfect for

- Teams deploying and managing multiple Kubernetes apps at scale 🌍
- Centralized management of shared Helm charts for standardization ⚙️
- Streamlining CI/CD workflows for Kubernetes deployments 🚀

Explore the charts, contribute, and streamline your Kubernetes deployments! 🤝

## Usage

### Setup kubeconfig

Update `<SERVER_IP>` with the IP address of your k3s server.

```bash
scp -i $HOME/.ssh/ansible_key ansible@<SERVER_IP>:/etc/rancher/k3s/k3s.yaml $HOME/k3s.yaml
sed -i '' 's/127.0.0.1/<SERVER_IP>/g' $HOME/k3s.yaml
chmod 600 $HOME/k3s.yaml
export KUBECONFIG=$HOME/k3s.yaml
sudo sed -i '' '/mosher-labs.local/d' /etc/hosts && \
  echo "<SERVER_IP> mosher-labs.local" | sudo tee -a /etc/hosts
kubectl get nodes
kubectl get deployments
kubectl get pods
kubectl get services

## More detailed queries
kubectl describe deployment hello-world
kubectl describe pod <pod-name>
```

### Deploy helm charts

Package the Helm chart if you want to create a .tgz file:

```bash
helm package hello-world
```

Use the helm upgrade --install command to deploy or upgrade the
Helm chart in your Kubernetes cluster. This command will install
the chart if it is not already installed or upgrade it if it is
already installed.

```bash
helm upgrade --install hello-world ./hello-world
```

After running the Helm upgrade command, you can verify that the deployment
was successful by checking the status of the release:

```bash
helm status hello-world
```

### Troubleshoot cluster

You can also use kubectl commands to check the status of the
pods, services, and other resources:

```bash
kubectl get all
```

To delete the hello-world deployment:

```bash
kubectl delete deployment hello-world
kubectl delete service hello-world
```

To verify the deletion:

```bash
kubectl get deployments
kubectl get services
```

## 🔰 Contributing

Upon first clone, install the pre-commit hooks.

```bash
pre-commit install
```

To run pre-commit hooks locally, without a git commit.

```bash
pre-commit run -a --all-files
```

To update pre-commit hooks, this ideally should be ran before a pull request is merged.

```bash
pre-commit autoupdate
```
