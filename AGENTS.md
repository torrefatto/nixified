# Context

This is a home manager configuration that caters on a nix distribution called nixtral (https://github.com/mistralai/nixtral).

It is a heavily customised version of it.

# Tools

To update the lock file and dependencies

```
nix --option access-tokens "github.com=$(gh auth token)" flake updat
```

To rebuild everything (the nixtral distribution defines this as `nixtral-rebuild`, an alias which non-interactive shells don't see)

```
nh home switch -b bak --configuration default
```
