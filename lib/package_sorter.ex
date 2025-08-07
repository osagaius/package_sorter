defmodule PackageSorter do
  @moduledoc """
  Package sorting module for robotic automation factory.
  Sorts packages into different stacks based on their dimensions and mass.
  """

  @doc """
  Sorts a package into the correct stack based on its dimensions and mass.

  A package is:
  - **bulky** if its volume (Width x Height x Length) is >= 1,000,000 cm³ or any dimension >= 150 cm
  - **heavy** when its mass is >= 20 kg

  Returns one of three stacks:
  - **STANDARD**: not bulky and not heavy
  - **SPECIAL**: either bulky or heavy (but not both)
  - **REJECTED**: both bulky and heavy

  ## Parameters
  - width: Width of the package in cm
  - height: Height of the package in cm
  - length: Length of the package in cm
  - mass: Mass of the package in kg

  ## Examples

      iex> PackageSorter.sort(99, 99, 99, 10)
      "STANDARD"

      iex> PackageSorter.sort(150, 100, 100, 10)
      "SPECIAL"

      iex> PackageSorter.sort(99, 99, 99, 20)
      "SPECIAL"

      iex> PackageSorter.sort(150, 100, 100, 20)
      "REJECTED"
  """
  @spec sort(number(), number(), number(), number()) :: String.t()
  def sort(width, height, length, mass) do
    is_bulky = bulky?(width, height, length)
    is_heavy = heavy?(mass)
    
    cond do
      is_bulky and is_heavy -> "REJECTED"
      is_bulky or is_heavy -> "SPECIAL"
      true -> "STANDARD"
    end
  end

  @doc """
  Determines if a package is bulky based on its dimensions.
  A package is bulky if:
  - Its volume is >= 1,000,000 cm³, or
  - Any of its dimensions is >= 150 cm
  """
  @spec bulky?(number(), number(), number()) :: boolean()
  defp bulky?(width, height, length) do
    volume = width * height * length
    volume >= 1_000_000 or width >= 150 or height >= 150 or length >= 150
  end

  @doc """
  Determines if a package is heavy based on its mass.
  A package is heavy if its mass is >= 20 kg.
  """
  @spec heavy?(number()) :: boolean()
  defp heavy?(mass), do: mass >= 20
end
