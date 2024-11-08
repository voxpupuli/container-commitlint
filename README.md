# Vox Pupuli Commitlint Container

[![CI](https://github.com/voxpupuli/container-commitlint/actions/workflows/ci.yaml/badge.svg)](https://github.com/voxpupuli/container-commitlint/actions/workflows/ci.yaml)
[![License](https://img.shields.io/github/license/voxpupuli/container-commitlint.svg)](https://github.com/voxpupuli/container-commitlint/blob/main/LICENSE)
[![Sponsored by betadots GmbH](https://img.shields.io/badge/Sponsored%20by-betadots%20GmbH-blue.svg)](https://www.betadots.de)

This container can be used to lint commits.
It encapsulates [commitlint](https://github.com/conventional-changelog/commitlint) and all necessary plugins.
See [package.json](package.json) for details. This is a npm application running in an alpine container.

## Usage

### Lint last commit only

```shell
podman run -it --rm -v $PWD:/data ghcr.io/voxpupuli/commitlint:latest
# or (but thats the default)
podman run -it --rm -v $PWD:/data ghcr.io/voxpupuli/commitlint:latest --last
```

### Lint all commits from a branch

```shell
podman run -it --rm -v $PWD:/data ghcr.io/voxpupuli/commitlint:latest \
  --from $(git merge-base $(git symbolic-ref refs/remotes/origin/HEAD --short) HEAD) \
  --to HEAD
```

### More options

For more options see:

```shell
podman run -it --rm -v $PWD:/data ghcr.io/voxpupuli/commitlint:latest --help
```

### Example commitlint config

See [.commitlint.yaml](.commitlintrc.yaml)

```yaml
---
# The rules below have been manually copied from @commitlint/config-conventional
# and match the v1.0.0 specification:
# https://www.conventionalcommits.org/en/v1.0.0/#specification
#
# You can remove them and uncomment the config below when the following issue is
# fixed: https://github.com/conventional-changelog/commitlint/issues/613
#
# extends:
#   - '@commitlint/config-conventional'
rules:
  body-leading-blank: [1, always]
  body-max-line-length: [2, always, 100]
  footer-leading-blank: [1, always]
  footer-max-line-length: [2, always, 100]
  header-max-length: [2, always, 100]
  subject-case:
    - 2
    - never
    - [sentence-case, start-case, pascal-case, upper-case]
  subject-empty: [2, never]
  subject-full-stop: [2, never, "."]
  type-case: [2, always, lower-case]
  type-empty: [2, never]
  type-enum:
    - 2
    - always
    - [build, chore, ci, docs, feat, fix, perf, refactor, revert, style, test]
```
