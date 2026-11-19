///|
test "AnyMutableMap get - returns values through typed references" {
  let request_id : @any-collection.AnyRef[String, String] = @any-collection.AnyRef::AnyRef(
    "request_id",
  )
  let retry_count : @any-collection.AnyRef[String, Int32] = @any-collection.AnyRef::AnyRef(
    "retry_count",
  )
  let context = @any-collection.AnyMutableMap::AnyMutableMap(
    [request_id.entry("request-1"), retry_count.entry(2)],
    capacity=8,
  )
  debug_inspect(context.get(request_id), content="Some(\"request-1\")")
  debug_inspect(context.get(retry_count), content="Some(2)")
}

///|
test "AnyMutableMap get variants - handle conversion errors explicitly" {
  let count : @any-collection.AnyRef[Int32, Int32] = @any-collection.AnyRef::AnyRef(
    1,
  )
  let text : @any-collection.AnyRef[Int32, String] = @any-collection.AnyRef::AnyRef(
    1,
  )
  let missing : @any-collection.AnyRef[Int32, String] = @any-collection.AnyRef::AnyRef(
    2,
  )
  let context = @any-collection.AnyMutableMap::AnyMutableMap([count.entry(2)])
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

///|
test "AnyMutableMap map - exposes operations without typed conversion" {
  let request_id : @any-collection.AnyRef[String, String] = @any-collection.AnyRef::AnyRef(
    "request_id",
  )
  let context = @any-collection.AnyMutableMap::AnyMutableMap([])
  context.set(request_id, "request-1")
  context.map.remove(request_id.key)
  debug_inspect(context.get(request_id), content="None")
  inspect(context.map.contains(request_id.key), content="false")
  inspect(context.map.length(), content="0")
  inspect(context.map.is_empty(), content="true")
}
