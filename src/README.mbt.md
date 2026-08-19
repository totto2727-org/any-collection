# any-collection

`totto2727/any-collection` provides mutable and persistent immutable maps whose values are stored as `Yoorkin/any.Any` and retrieved through reusable typed references.

## Usage

```mbt check
///|
test {
  let request_id : AnyRef[String, String] = AnyRef::AnyRef("request_id")
  let retry_count : AnyRef[String, Int] = AnyRef::AnyRef("retry_count")

  let mutable = AnyMutableMap::AnyMutableMap(
    [request_id.entry("request-1"), retry_count.entry(2)],
    capacity=8,
  )
  debug_inspect(mutable.get(request_id), content="Some(\"request-1\")")
  mutable.set(retry_count, 3)
  inspect(mutable.get_or(retry_count, 0), content="3")
  inspect(mutable.map.length(), content="2")

  let immutable = AnyImmutableHashMap::AnyImmutableHashMap([
    request_id.entry("request-2"),
  ])
  let updated = immutable.added(request_id, "request-3")
  debug_inspect(immutable.get(request_id), content="Some(\"request-2\")")
  debug_inspect(updated.get(request_id), content="Some(\"request-3\")")
  inspect(updated.map.contains(request_id.key), content="true")
}
```

## Key features

- `AnyRef[K, T]` keeps a key and its typed encoder/decoder together.
- `AnyMutableMap` mutates in place, while `AnyImmutableHashMap` returns a new map from `added`.
- Both wrappers expose their underlying map for operations that do not need typed conversion.

## Prerequisites

- **MoonBit**: Install the MoonBit toolchain and package manager.
- **Yoorkin/any**: The module dependency supplies `Any` and `Anyable`.

## Setup

1. Add the module to a MoonBit project.

```bash
moon add totto2727/any-collection@0.2.1
```

## API

[Mooncakes API reference](https://mooncakes.io/docs/totto2727/any-collection)

## Typed access

`AnyMutableMap::AnyMutableMap(entries, capacity?)` delegates to the underlying `Map` constructor, while `AnyImmutableHashMap::AnyImmutableHashMap(entries)` delegates to `@immut.HashMap`. Pass `[]` to create an empty collection, use `AnyRef::entry` for typed constructor entries, or provide raw `Yoorkin/any.Any` pairs.

`get` returns `None` for an absent key and raises the original conversion error when the stored runtime type does not match the reference. `get_or` replaces absence and conversion errors with its default; `get_or_none` replaces conversion errors with `None` while preserving successful and missing results.

Define one shared `AnyRef[K, T]` for each key and value type. Core MoonBit types already implement `Yoorkin/any.Anyable`; custom values must extend `Yoorkin/any.Payload` and implement `Anyable`, as shown in [`examples/basic/main.mbt`](examples/basic/main.mbt).

## Development

For repository structure and development commands, see [AGENTS.md](../AGENTS.md).

## License

[MIT](../LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
