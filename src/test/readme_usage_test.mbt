///|
test "README usage - updates a retry context without changing its baseline snapshot" {
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
