# any-collection

`totto2727/any-collection` provides mutable and immutable maps whose values are stored as `Yoorkin/any.Any` and retrieved through reusable typed references.

This document is canonical `README.mbt.md`; maintain `README.md` as the relative symlink `README.md -> README.mbt.md`.

## Usage

```mbt check
///|
test {
  let request_id : @any_collection.AnyRef[String, String] =
    @any_collection.AnyRef::AnyRef("request_id")
  let retry_count : @any_collection.AnyRef[String, Int] =
    @any_collection.AnyRef::AnyRef("retry_count")

  let mutable = @any_collection.AnyMutableMap::AnyMutableMap([
    request_id.entry("request-1"),
    retry_count.entry(2),
  ], capacity=8)
  debug_inspect(mutable.get(request_id), content="Some(\"request-1\")")
  mutable.set(retry_count, 3)
  inspect(mutable.get_or(retry_count, 0), content="3")
  inspect(mutable.map.length(), content="2")

  let immutable = @any_collection.AnyImmutableHashMap::AnyImmutableHashMap([
    request_id.entry("request-2"),
  ])
  let updated = immutable.added(request_id, "request-3")
  debug_inspect(immutable.get(request_id), content="Some(\"request-2\")")
  debug_inspect(updated.get(request_id), content="Some(\"request-3\")")
  inspect(updated.map.contains(request_id.key), content="true")
}
```

## Key features

- Reusable `AnyRef[K, T]` values keep typed reads aligned with each key.
- Mutable and persistent immutable map wrappers share the same reference API.
- Fallback getters handle missing keys and runtime conversion errors explicitly.

## Prerequisites

- **MoonBit**: Install the MoonBit toolchain and package manager.

## Setup

1. Add the package to a MoonBit project.

```bash
moon add totto2727/any-collection@0.2.1
```

## API

[Mooncakes API reference](https://mooncakes.io/docs/totto2727/any-collection)

## Development

For project structure and development commands, see [AGENTS.md](./AGENTS.md).

## License

[MIT](./LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
