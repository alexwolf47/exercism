defmodule Test do
  def test(result) do
    if result > 5 do
      result + 5
    else
      result + 2
    end
  end
end

IO.inspect(Test.test(6))
