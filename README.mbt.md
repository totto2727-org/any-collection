# any-collection

`totto2727/any-collection` is a MoonBit module for mutable and persistent immutable maps whose values are stored as `Yoorkin/any.Any` and read through reusable typed references.

## Usage

```moonbit
///|
test {
  let request_id : @any_collection.AnyRef[String, String] =
    @any_collection.AnyRef::AnyRef("request_id")
  let values = @any_collection.AnyMutableMap::AnyMutableMap([
    request_id.entry("request-1"),
  ])
  debug_inspect(values.get(request_id), content="Some(\"request-1\")")
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
moon add totto2727/any-collection@0.2.1
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
