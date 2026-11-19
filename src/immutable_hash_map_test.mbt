///|
test "AnyImmutableHashMap added - preserves the original map" {
  let request_id : @any-collection.AnyRef[String, String] = @any-collection.AnyRef::AnyRef(
    "request_id",
  )
  let original = @any-collection.AnyImmutableHashMap::AnyImmutableHashMap([
    request_id.entry("request-1"),
  ])
  let updated = original.added(request_id, "request-2")
  debug_inspect(original.get(request_id), content="Some(\"request-1\")")
  debug_inspect(updated.get(request_id), content="Some(\"request-2\")")
  inspect(updated.map.contains(request_id.key), content="true")
  inspect(updated.map.length(), content="1")
}

///|
test "AnyImmutableHashMap map - exposes persistent operations" {
  let request_id : @any-collection.AnyRef[String, String] = @any-collection.AnyRef::AnyRef(
    "request_id",
  )
  let populated = @any-collection.AnyImmutableHashMap::AnyImmutableHashMap([
    request_id.entry("request-1"),
  ])
  let removed = @any-collection.AnyImmutableHashMap::AnyImmutableHashMap(
    populated.map.remove(request_id.key).to_array(),
  )
  debug_inspect(populated.get(request_id), content="Some(\"request-1\")")
  debug_inspect(removed.get(request_id), content="None")
  inspect(removed.map.length(), content="0")
}

///|
test "AnyImmutableHashMap get variants - handle conversion errors explicitly" {
  let count : @any-collection.AnyRef[Int32, Int32] = @any-collection.AnyRef::AnyRef(
    1,
  )
  let text : @any-collection.AnyRef[Int32, String] = @any-collection.AnyRef::AnyRef(
    1,
  )
  let missing : @any-collection.AnyRef[Int32, String] = @any-collection.AnyRef::AnyRef(
    2,
  )
  let context = @any-collection.AnyImmutableHashMap::AnyImmutableHashMap([
    count.entry(2),
  ])
  let mismatch_raised = try {
    context.get(text) |> ignore
    false
  } catch {
    Failure::Failure(_) => true
    _ => false
  }
  inspect(mismatch_raised, content="true")
  inspect(context.get_or(text, "fallback"), content="fallback")
  inspect(context.get_or(missing, "fallback"), content="fallback")
  debug_inspect(context.get_or_none(text), content="None")
  debug_inspect(context.get_or_none(missing), content="None")
}
