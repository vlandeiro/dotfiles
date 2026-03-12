---
name: git-workflow
description: Use when committing, staging files, writing commit messages, pushing, or following git conventions. Covers conventional commit format and safe git operations.
---

# Git Workflow

## Committing

Only commit when explicitly requested. Follow this order:

1. Check working tree state
2. Draft a meaningful commit message
3. Stage specific files (not `git add .` or `git add -A`)
4. Create the commit
5. Verify success

## Commit Message Format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Types

- `feat`: A new feature
- `fix`: A bug fix
- `docs`: Documentation only changes
- `style`: Changes that do not affect the meaning of the code
- `refactor`: A code change that neither fixes a bug nor adds a feature
- `perf`: A code change that improves performance
- `test`: Adding missing tests or correcting existing tests
- `chore`: Changes to the build process, dependencies, or tooling

### Examples

```
feat: add user authentication
fix: resolve null pointer in user service
docs: update API endpoint documentation
```

## Constraints

- Do not amend published commits
- Do not skip hooks (`--no-verify`)
- Do not force push to main/master
- Do not use `git add -A` or `git add .`
