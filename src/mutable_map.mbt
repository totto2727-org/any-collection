///|
/// A mutable map of dynamically typed values accessed through `AnyRef`.
///
/// The public `map` field exposes the underlying `Map[K, @any.Any]` for
/// operations that do not need typed conversion, including membership,
/// removal, length, emptiness, iteration, merging, and direct `Any` writes.
pub struct AnyMutableMap[K] {
  map : Map[K, @any.Any]
}

///|
/// Creates a mutable any map from key-value pairs.
///
/// The entries and optional `capacity` have the same meaning as the
/// underlying `Map` constructor. Pass `[]` for an empty map. Entries may be
/// produced with `AnyRef::entry` or supplied as raw `@any.Any` pairs.
pub fn[K : Hash + Eq] AnyMutableMap::AnyMutableMap(
  entries : ArrayView[(K, @any.Any)],
  capacity? : Int,
) -> AnyMutableMap[K] {
  { map: Map(entries, capacity?) }
}

///|
/// Associates `value` with `reference`, replacing an existing value.
pub fn[K : Hash + Eq, T] AnyMutableMap::set(
  self : AnyMutableMap[K],
  reference : AnyRef[K, T],
  value : T,
) -> Unit {
  self.map[reference.key] = (reference.encode)(value)
}

///|
/// Returns the value selected by `reference` when it exists with type `T`.
///
/// A missing key or a value stored through a differently typed reference
/// returns `None` or raises the conversion error, respectively.
pub fn[K : Hash + Eq, T] AnyMutableMap::get(
  self : AnyMutableMap[K],
  reference : AnyRef[K, T],
) -> T? raise {
  match self.map.get(reference.key) {
    Some(value) => Some((reference.decode)(value))
    None => None
  }
}

///|
/// Returns the selected value, replacing a missing key or conversion error with
/// `default`.
pub fn[K : Hash + Eq, T] AnyMutableMap::get_or(
  self : AnyMutableMap[K],
  reference : AnyRef[K, T],
  default : T,
) -> T {
  self.get(reference).unwrap_or(default) catch {
    _ => default
  }
}

///|
/// Returns the selected value, replacing a conversion error with `None`.
pub fn[K : Hash + Eq, T] AnyMutableMap::get_or_none(
  self : AnyMutableMap[K],
  reference : AnyRef[K, T],
) -> T? {
  self.get(reference) catch {
    _ => None
  }
}
