defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun) do
    keep(list, fun, [])
  end

  def keep([h | t], fun, result) do
    result =
      if fun.(h) do
        result ++ [h]
      else
        result
      end

    keep(t, fun, result)
  end

  def keep([], _fun, result) do
    result
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun) do
    discard(list, fun, list)
  end

  def discard([h | t], fun, result) do
    result =
      if fun.(h) do
        result -- [h]
      else
        result
      end

    discard(t, fun, result)
  end

  def discard([], _fun, result) do
    result
  end
end
