defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    code
    |> Integer.to_string(2)
    |> String.reverse()
    |> wink?([])
  end

  defp wink?(code, result) do
    case String.at(code, 0) do
      "1" -> doubleblink?(code, result ++ ["wink"])
      "0" -> doubleblink?(code, result)
      nil -> result
    end
  end

  defp doubleblink?(code, result) do
    case String.at(code, 1) do
      "1" -> cye?(code, result ++ ["double blink"])
      "0" -> cye?(code, result)
      nil -> result
    end
  end
  defp cye?(code, result) do
    case String.at(code, 2) do
      "1" -> jump?(code, result ++ ["close your eyes"])
      "0" -> jump?(code, result)
      nil -> result
    end
  end
  defp jump?(code, result) do
    case String.at(code, 3) do
      "1" -> reverse?(code, result ++ ["jump"])
      "0" -> reverse?(code, result)
      nil -> result
    end
  end
  defp reverse?(code, result) do
    case String.at(code, 4) do
      "1" -> Enum.reverse(result)
      _ -> result
    end
  end
end
