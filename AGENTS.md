# any-collection

## Repository structure

```text
README.mbt.md                Canonical end-user module overview
README.md                    Relative symlink to README.mbt.md
LICENSE                      Module license
src/                         AnyRef and mutable/immutable map implementations
src/*_test.mbt               Package tests for public behavior
src/test/                    Current-source contract for root README Usage
src/examples/basic/          Executable custom-payload example
moon.mod                     MoonBit module metadata and Mooncakes package settings
flake.nix                    Reproducible MoonBit development shell
.github/workflows/           CI and Mooncakes publishing workflows
```

## Development commands

### Execution rules

- Run commands from the repository root.
- Enter the pinned toolchain with `nix develop` before running MoonBit commands.
- Keep root `README.mbt.md` canonical for the module overview and preserve the relative `README.md -> README.mbt.md` symlink.
- Keep `src/test/readme_usage_test.mbt` aligned with the root README Usage so its exact consumer API is tested against the current workspace source.
- Regenerate interfaces after public API changes and inspect the resulting `.mbti` diff.
- Do not add a package-level `AGENTS.md` unless the source package gains rules that are genuinely unique to it.

### Standard tasks

- `nix develop` — Enter the pinned MoonBit development environment.
- `moon info` — Regenerate package interface information after public API changes.
- `moon fmt` — Format MoonBit sources and literate Markdown blocks.
- `moon check` — Type-check the library and example packages.
- `moon test` — Run the package tests.
- `moon build` — Build the library and example packages.
- `moon test src/test/readme_usage_test.mbt` — Execute the root README Usage contract against the current workspace source.
- `moon package --list` — Confirm the packages included in publication.
- `moon package` — Build the publication archive and inspect its root/module and source/package paths.
- `nix flake check --all-systems --no-build` — Validate the Nix flake without building.

## Architecture

### Typed references

- `AnyRef[K, T]` owns the key and the `Yoorkin/any` encode/decode boundary.
- Callers should share one reference for each key and value type; a mismatched reference raises on `get` and is handled by fallback getters.

### Collection wrappers

- `AnyMutableMap` delegates construction and untyped operations to `Map[K, @any.Any]` and mutates through `set`.
- `AnyImmutableHashMap` delegates construction and persistent operations to `@immut.HashMap` and returns new values from `added`.
- Both wrappers expose their underlying `map` field for operations that do not require typed conversion.

### Documentation and publication

- Mooncakes is the canonical maintained API index; keep README API content to the direct registry link.
- Public behavior belongs in `///` documentation and executable package or README examples.
- `moon.mod` owns module metadata, the root `README.mbt.md` path, the root `LICENSE`, and the `source = "./src"` package boundary.
- The publication archive keeps root module artifacts at its top level and implementation/package artifacts under `src/`; do not duplicate root guidance or the license as package aliases.
- The publishing workflow runs only on `main` and uses the repository's shared MoonBit publication action.

## Development tools

- **MoonBit**: Builds, checks, tests, documents, and packages the library.
- **Nix flakes**: Pin the MoonBit toolchain for local and CI-compatible validation.
- **Mooncakes**: Publishes the versioned package and hosts the generated API reference.
- **GitHub Actions**: Runs CI and publication workflows.

## Package-specific rules

- Keep custom stored values compatible with `Yoorkin/any.Anyable`; custom types extend `Yoorkin/any.Payload` and implement `Anyable` as shown in `src/examples/basic/main.mbt`.
- Keep the `moon.mod` `readme = "README.mbt.md"` setting aligned with the root canonical module README.

_This AGENTS.md was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [AGENTS template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/agents/template.md)._
