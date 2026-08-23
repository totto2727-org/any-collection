# any-collection

`totto2727/any-collection` is a MoonBit module for mutable and persistent immutable maps whose values are stored as `Yoorkin/any.Any` and read through reusable typed references.

## Usage

```mbt check
///|
test "update a retry context without changing its baseline snapshot" {
  let request_id : @any_collection.AnyRef[String, String] = @any_collection.AnyRef::AnyRef(
    "request_id",
  )
  let retry_count : @any_collection.AnyRef[String, Int] = @any_collection.AnyRef::AnyRef(
    "retry_count",
  )
  let live_context = @any_collection.AnyMutableMap::AnyMutableMap([])
  live_context.set(request_id, "req-42")
  live_context.set(retry_count, 0)
  live_context.set(retry_count, live_context.get_or(retry_count, 0) + 1)

  let baseline = @any_collection.AnyImmutableHashMap::AnyImmutableHashMap([
    request_id.entry("req-42"),
    retry_count.entry(0),
  ])
  let retry_snapshot = baseline.added(
    retry_count,
    live_context.get_or(retry_count, 0),
  )

  inspect(live_context.get_or(request_id, ""), content="req-42")
  inspect(live_context.get_or(retry_count, 0), content="1")
  inspect(baseline.get_or(retry_count, 0), content="0")
  inspect(retry_snapshot.get_or(retry_count, 0), content="1")
}
```

## Key features

- Reusable typed references keep each key's value type explicit.
- Mutable and persistent immutable map wrappers use the same reference API.
- Fallback getters make missing keys and conversion errors easy to handle.

## Prerequisites

- **MoonBit**: Install the MoonBit toolchain and package manager.

## Setup

1. Add the required modules to a MoonBit project.

```bash
moon add Yoorkin/any@0.2.1
moon add totto2727/any-collection@0.2.2
```

2. Import the package from the consumer package's `moon.pkg`.

```moonbit
import {
  "Yoorkin/any",
  "totto2727/any-collection" @any_collection,
}
```

## API

[Mooncakes API reference](https://mooncakes.io/docs/totto2727/any-collection)

## Development

For repository structure and development commands, see [AGENTS.md](./AGENTS.md).

## License

[MIT](./LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
