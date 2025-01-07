# basic-helm-charts-template

![GitHub branch status](https://img.shields.io/github/checks-status/mosher-labs/basic-helm-charts-template/main)
![GitHub Issues](https://img.shields.io/github/issues/mosher-labs/basic-helm-charts-template)
![GitHub last commit](https://img.shields.io/github/last-commit/mosher-labs/basic-helm-charts-template)
![GitHub repo size](https://img.shields.io/github/repo-size/mosher-labs/basic-helm-charts-template)
![Libraries.io dependency status for GitHub repo](https://img.shields.io/librariesio/github/mosher-labs/basic-helm-charts-template)
![GitHub License](https://img.shields.io/github/license/mosher-labs/basic-helm-charts-template)
![GitHub Sponsors](https://img.shields.io/github/sponsors/mosher-labs)

## 🎩 Basic Helm Charts Template 🚢

Welcome to the Basic Helm Charts Template repository! 🚀 This repo
provides a clean, minimal starting point for creating and managing
Helm charts for Kubernetes applications. 🎯

### 🌟 Key Features

- 📂 Pre-organized structure for efficient chart development.
- 🛠️ Includes essential templates for ConfigMaps, Deployments, Services, and more.
- 🔧 Easy customization for a wide range of Kubernetes workloads.
- 📜 Follows Helm best practices for readability and maintainability.

### ✨ Perfect for

- Developers and DevOps teams setting up new Helm charts quickly 🛠️
- Learning Helm with a streamlined template 📚
- Building consistent and reusable deployment configurations 🚀

Clone, customize, and deploy with confidence! 🤝

## Usage

To use this repository template, simply fork the repo.

```bash
gh repo fork --fork-name <FORK_NAME> --org <ORG_NAME>
```

Update the repository settings:

```bash
gh repo edit --add-topic devops,reliability-engineering,axes \
--add-topic infrastructure-as-code,viking,mosher-labs \
--add-topic helm,helm-charts,kubernetes,k8s \
--delete-branch-on-merge --enable-discussions=false \
--enable-issues=false --enable-merge-commit=false \
--enable-projects=false --enable-rebase-merge=false \
--enable-wiki=false
```

Create a ruleset for the default branch.

- Ruleset Name: Default branch
- Enforcement status: Active
- Target Branches: Default
- ✅ Restrict deletions
- ✅ Require linear history
- ✅ Require signed commits
- ✅ Require a pull request before merging
- ✅ Dismiss stale pull request approvals when new commits are pushed
- ✅ Require conversation resolution before merging
- ✅ Request pull request review from Copilot
- Allowed merge methods: "Squash"
- ✅ Require status checks to pass
- ✅ Require branches to be up to date before merging
- ✅ Do not require status checks on creation
- Status checks that are required: `pre-commit/pre-commit`
- ✅ Block force pushes
- ✅ Require code scanning results

Enable Dependabot.

- In Github UI, navigate to the repositories Settings > Code security
- Enable Dependabot security updates
- Enable Grouped security updates
- Enable Dependabot version updates
- Enable Dependabot on Actions runners
- CodeQL analysis > Set up > Default
- Enable Secret scanning
- Enable Push protection

Update the templated information:

### README.md

- [ ] Replace `basic-helm-charts-template` with your `<FORK_NAME>`
- [ ] Run this command to update template information:

  ```bash
  sed -e 's/basic-helm-charts-template/<FORK_NAME>/g' | \
  find . -type f ! -path './.git/*'
  ```

- [ ] Update the "Introduction" section
- [ ] Update the "Usage" section
- [ ] Update the "Contributing" section

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
