///|
/// An immutable hash map of dynamically typed values accessed through
/// `AnyRef`.
///
/// The public `map` field exposes the underlying persistent hash map for
/// operations that do not need typed conversion, including membership,
/// removal, length, emptiness, iteration, merging, and direct `Any` values.
pub struct AnyImmutableHashMap[K] {
  map : @immut.HashMap[K, @any.Any]
}

///|
/// Creates an immutable any hash map from key-value pairs.
///
/// The entries have the same meaning as the underlying `@immut.HashMap`
/// constructor. Pass `[]` for an empty map. Entries may be produced with
/// `AnyRef::entry` or supplied as raw `@any.Any` pairs.
pub fn[K : Hash + Eq] AnyImmutableHashMap::AnyImmutableHashMap(
  entries : ArrayView[(K, @any.Any)],
) -> AnyImmutableHashMap[K] {
  { map: @immut.HashMap::HashMap(entries) }
}

///|
/// Returns a map associating `value` with `reference` without changing this map.
/// The same `AnyRef` instance can be used with mutable and immutable maps.
pub fn[K : Hash + Eq, T] AnyImmutableHashMap::added(
  self : AnyImmutableHashMap[K],
  reference : AnyRef[K, T],
  value : T,
) -> AnyImmutableHashMap[K] {
  { map: self.map.add(reference.key, (reference.encode)(value)) }
}

///|
/// Returns the value selected by `reference` when it exists with type `T`.
///
/// A missing key or a value stored through a differently typed reference
/// returns `None` or raises the conversion error, respectively.
pub fn[K : Hash + Eq, T] AnyImmutableHashMap::get(
  self : AnyImmutableHashMap[K],
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
pub fn[K : Hash + Eq, T] AnyImmutableHashMap::get_or(
  self : AnyImmutableHashMap[K],
  reference : AnyRef[K, T],
  default : T,
) -> T {
  self.get(reference).unwrap_or(default) catch {
    _ => default
  }
}

///|
/// Returns the selected value, replacing a conversion error with `None`.
pub fn[K : Hash + Eq, T] AnyImmutableHashMap::get_or_none(
  self : AnyImmutableHashMap[K],
  reference : AnyRef[K, T],
) -> T? {
  self.get(reference) catch {
    _ => None
  }
}
