defmodule KV.Bucket do
  use Agent

  @doc """
  Starts a new bucket
  """
  def start_link(opts) do
    Agent.start_link(fn -> %{} end, opts)
  end

  @doc """
  Gets the value from the `bucket` by `key`
  """
  def get(bucket, key) do
    Agent.get(bucket, fn map -> Map.get(map, key) end)
  end

  @doc """
  Puts the `value` for the given `key` in the `bucket`
  """
  def put(bucket, key, value) do
    Agent.update(bucket, fn map -> Map.put(map, key, value) end)
  end

  @doc """
  Deletes `key` from `bucket`

  Returns current value of `key`, if `key` exists
  """
  def delete(bucket, key) do
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end
end
