# Package Sorter - Robotic Sorting System

## What is this?

This is a simple package sorting system/service designed for a robotic automation factory. The system analyzes package dimensions and weight to determine how they should be handled in the warehouse.

## How It Works

The system sorts packages into three different categories:

- **STANDARD**: Regular packages that can be handled normally (neither bulky nor heavy)
- **SPECIAL**: Packages that need special handling (either bulky OR heavy)
- **REJECTED**: Packages that cannot be processed (both bulky AND heavy)

## Package Classification Rules

- **Bulky package**: Either its volume is ≥ 1,000,000 cm³ (1 cubic meter) OR any dimension is ≥ 150 cm
- **Heavy package**: Weight is ≥ 20 kg

## Interactive Demo

### Installing Elixir

1. **macOS** (using Homebrew):

   ```bash
   brew install elixir
   ```

2. **Linux** (Ubuntu/Debian):
   ```bash
   wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
   sudo dpkg -i erlang-solutions_2.0_all.deb
   sudo apt-get update
   sudo apt-get install esl-erlang elixir
   ```

### Usage in IEx Console

After installing Elixir, you can try the package sorter in the interactive Elixir console (IEx):

1. Clone this repository and navigate to its directory
2. Start the IEx console with the project loaded:
   ```bash
   iex -S mix
   ```
3. Use the `sort` function:

   ```elixir
   # Usage: PackageSorter.sort(width, height, length, mass)

   # Example: Standard package
   iex> PackageSorter.sort(90, 90, 90, 15)
   "STANDARD"

   # Example: Special package (bulky)
   iex> PackageSorter.sort(150, 90, 90, 15)
   "SPECIAL"

   # Example: Another package (heavy)
   iex> PackageSorter.sort(90, 90, PackageSorter.sort(150, 90, 90, 20)90, 20)
   "SPECIAL"

   # Example: Rejected package (both bulky and heavy)
   iex> PackageSorter.sort(150, 90, 90, 20)
   "REJECTED"
   ```

Where:

- `width`, `height`, and `length` are dimensions in centimeters
- `mass` is in kilograms

Returns: String with the classification result ("STANDARD", "SPECIAL", or "REJECTED")

### Running Tests

To run the tests, use the following command:

```bash
mix test
```
