# dotfiles

Personal dotfiles managed with [chezmoi](https://www.chezmoi.io/).

## Setup

### Prerequisites

Install chezmoi:

```sh
brew install chezmoi
```

### First-time setup on a new machine

```sh
chezmoi init --apply vlandeiro
```

This clones the repo and applies all dotfiles in one step.

### Updating after changes

Pull and apply the latest changes:

```sh
chezmoi update
```

### Editing a managed file

```sh
chezmoi edit ~/.zshrc
chezmoi apply
```

## Structure

chezmoi uses filename prefixes to determine how files are managed:

| Prefix | Meaning |
|--------|---------|
| `dot_` | Becomes a dotfile (e.g. `dot_zshrc` → `~/.zshrc`) |
| `private_` | Applied with restricted permissions (600) |
| `executable_` | Applied with executable permissions |

## Security

This repo uses [gitleaks](https://github.com/gitleaks/gitleaks) as a pre-commit hook to prevent accidentally committing secrets.

Secrets and credentials are not stored here. Use chezmoi's [secret manager integrations](https://www.chezmoi.io/user-guide/password-managers/) or keep them in `~/.secrets` (not managed by chezmoi).
