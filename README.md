# Package Sorter

A simple Elixir module to sort packages according to their volume and mass.

## Rules

- A package is **bulky** if its volume (Width x Height x Length) is greater than or equal to 1,000,000 cm³ or when one of its dimensions is greater or equal to 150 cm.
- A package is **heavy** when its mass is greater or equal to 20 kg.

Packages are sorted into the following stacks:

- **STANDARD**: standard packages (those that are not bulky or heavy) can be handled normally.
- **SPECIAL**: packages that are either heavy or bulky can't be handled automatically.
- **REJECTED**: packages that are **both** heavy and bulky are rejected.

## Usage

```elixir
PackageSorter.sort(width, height, length, mass)
```

Where:
- `width`, `height`, and `length` are dimensions in centimeters
- `mass` is in kilograms

Returns: String representing the stack name ("STANDARD", "SPECIAL", or "REJECTED")

## Running Tests

```
mix test
```
