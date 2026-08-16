# any-collection

## Repository structure

```text
src/                         AnyRef and mutable/immutable map implementations
src/*_test.mbt               Package tests for public behavior
src/examples/basic/          Executable custom-payload example
moon.mod                     MoonBit module metadata and Mooncakes package settings
flake.nix                    Reproducible MoonBit development shell
.github/workflows/           CI and Mooncakes publishing workflows
```

## Development commands

### Execution rules

- Run commands from the repository root.
- Enter the pinned toolchain with `nix develop` before running MoonBit commands.
- Keep `README.mbt.md` canonical and preserve the relative `README.md -> README.mbt.md` symlink.
- Regenerate interfaces after public API changes and inspect the resulting `.mbti` diff.
- Do not add a `CLAUDE.md` file; `AGENTS.md` is the requested canonical agent guidance.

### Standard tasks

- `nix develop` — Enter the pinned MoonBit development environment.
- `moon info` — Regenerate package interface information after public API changes.
- `moon check` — Type-check the library and example packages.
- `moon test` — Run the package tests.
- `moon check README.mbt.md` — Ask MoonBit to check the canonical README; with this module's `source = "./src"` layout, package-level checks are the effective validation path.
- `moon test README.mbt.md` — Run standalone README tests when the MoonBit toolchain accepts the document as a package input; otherwise use `moon test` for this source-root package layout.
- `moon package --list` — Confirm the packages included in publication.
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
- The publishing workflow runs only on `main` and uses the repository's shared MoonBit publication action.

## Development tools

- **MoonBit**: Builds, checks, tests, documents, and packages the library.
- **Nix flakes**: Pin the MoonBit toolchain for local and CI-compatible validation.
- **Mooncakes**: Publishes the versioned package and hosts the generated API reference.
- **GitHub Actions**: Runs CI and publication workflows.

## Package-specific rules

- Keep custom stored values compatible with `Yoorkin/any.Anyable`; custom types extend `Yoorkin/any.Payload` and implement `Anyable` as shown in `src/examples/basic/main.mbt`.
- Keep the `moon.mod` `readme = "README.mbt.md"` setting aligned with the canonical literate README.

_This AGENTS.md was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [AGENTS template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/agents/template.md)._
