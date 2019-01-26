defmodule RobotSimulator do
  @valid_directions [:north, :east, :south, :west]
  @invalid_direction {:error, "invalid direction"}
  @invalid_position {:error, "invalid position"}

  # def create() do
  #   robot = %{"direction" => :north, "position" => {0, 0}}
  # end

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create() do
    %{"direction" => :north, "position" => {0, 0}}
  end

  def create(direction, position) do
    %{"direction" => direction, "position" => position}
    |> check_valid_direction()
    |> check_valid_position()
  end

  defp check_valid_direction(robot) do
    if Enum.member?(@valid_directions, robot["direction"]) do
      robot
    else
      @invalid_direction
    end
  end

  defp check_valid_position({:error, _} = robot) do
    robot
  end

  defp check_valid_position(robot) do
    position = robot["position"]

    # Checks that position is a valid tuple of two coordinates, both integers
    if is_tuple(position) && tuple_size(position) == 2 && is_integer(elem(position, 0)) &&
         is_integer(elem(position, 1)) do
      robot
    else
      @invalid_position
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate({:error, _}, _) do
    {:error, "invalid instruction"}
  end

  def simulate(robot, instructions) when is_binary(instructions) do
    instructions = to_charlist(instructions)
    simulate(robot, instructions)
  end

  def simulate(robot, [this_move | later_moves]) do
    moving_robot = move(robot, this_move)
    simulate(moving_robot, later_moves)
  end

  def simulate(finished_moving_robot, []) do
    finished_moving_robot
  end

  def move(robot, ?R) do
    case robot["direction"] do
      :north -> %{robot | "direction" => :east}
      :east -> %{robot | "direction" => :south}
      :south -> %{robot | "direction" => :west}
      :west -> %{robot | "direction" => :north}
    end
  end

  def move(robot, ?L) do
    case robot["direction"] do
      :north -> %{robot | "direction" => :west}
      :east -> %{robot | "direction" => :north}
      :south -> %{robot | "direction" => :east}
      :west -> %{robot | "direction" => :south}
    end
  end

  def move(%{"position" => {x, y}} = robot, ?A) do
    case robot["direction"] do
      :north -> %{robot | "position" => {x, y + 1}}
      :east -> %{robot | "position" => {x + 1, y}}
      :south -> %{robot | "position" => {x, y - 1}}
      :west -> %{robot | "position" => {x - 1, y}}
    end
  end

  def move(_robot, _) do
    {:error, "invalid instruction"}
  end

  # @doc """
  # Return the robot's direction.

  # Valid directions are: `:north`, `:east`, `:south`, `:west`
  # """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot["direction"]
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot["position"]
  end
end
