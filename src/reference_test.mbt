///|
test "AnyRef - is shared by mutable and immutable maps" {
  let request_id : @any-collection.AnyRef[String, String] = @any-collection.AnyRef::AnyRef(
    "request_id",
  )
  let mutable = @any-collection.AnyMutableMap::AnyMutableMap([])
  let immutable = @any-collection.AnyImmutableHashMap::AnyImmutableHashMap([]).added(
    request_id, "immutable-request",
  )
  mutable.set(request_id, "mutable-request")
  debug_inspect(mutable.get(request_id), content="Some(\"mutable-request\")")
  debug_inspect(
    immutable.get(request_id),
    content="Some(\"immutable-request\")",
  )
}

///|
test "AnyRef entry - creates a typed constructor entry" {
  let request_id : @any-collection.AnyRef[String, String] = @any-collection.AnyRef::AnyRef(
    "request_id",
  )
  let (key, value) = request_id.entry("request-1")
  inspect(key, content="request_id")
  inspect((value.dyn_cast() : String), content="request-1")
}
