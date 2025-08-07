defmodule PackageSorterTest do
  use ExUnit.Case
  doctest PackageSorter

  describe "sort/4" do
    test "returns STANDARD when package is neither bulky nor heavy" do
      # Small dimensions and light weight
      assert PackageSorter.sort(10, 10, 10, 10) == "STANDARD"
      
      # Close to bulky by volume but not enough
      assert PackageSorter.sort(100, 99, 100, 10) == "STANDARD"
      
      # Close to bulky by dimension but not enough
      assert PackageSorter.sort(149, 50, 50, 10) == "STANDARD"
      
      # Close to heavy but not enough
      assert PackageSorter.sort(50, 50, 50, 19.99) == "STANDARD"
    end

    test "returns SPECIAL when package is bulky but not heavy" do
      # Bulky by volume
      assert PackageSorter.sort(100, 100, 100, 10) == "SPECIAL" # Volume = 1,000,000
      assert PackageSorter.sort(110, 100, 100, 10) == "SPECIAL" # Volume > 1,000,000
      
      # Bulky by width dimension
      assert PackageSorter.sort(150, 10, 10, 10) == "SPECIAL"
      assert PackageSorter.sort(200, 10, 10, 10) == "SPECIAL"
      
      # Bulky by height dimension
      assert PackageSorter.sort(10, 150, 10, 10) == "SPECIAL"
      assert PackageSorter.sort(10, 200, 10, 10) == "SPECIAL"
      
      # Bulky by length dimension
      assert PackageSorter.sort(10, 10, 150, 10) == "SPECIAL"
      assert PackageSorter.sort(10, 10, 200, 10) == "SPECIAL"
    end

    test "returns SPECIAL when package is heavy but not bulky" do
      # Heavy but small dimensions
      assert PackageSorter.sort(10, 10, 10, 20) == "SPECIAL"
      assert PackageSorter.sort(10, 10, 10, 25) == "SPECIAL"
      
      # Heavy and close to bulky but not quite
      assert PackageSorter.sort(99, 99, 99, 20) == "SPECIAL"
      assert PackageSorter.sort(149, 50, 50, 30) == "SPECIAL"
    end

    test "returns REJECTED when package is both bulky and heavy" do
      # Bulky by volume and heavy
      assert PackageSorter.sort(100, 100, 100, 20) == "REJECTED"
      assert PackageSorter.sort(110, 100, 100, 25) == "REJECTED"
      
      # Bulky by width dimension and heavy
      assert PackageSorter.sort(150, 10, 10, 20) == "REJECTED"
      assert PackageSorter.sort(200, 10, 10, 30) == "REJECTED"
      
      # Bulky by height dimension and heavy
      assert PackageSorter.sort(10, 150, 10, 20) == "REJECTED"
      assert PackageSorter.sort(10, 200, 10, 30) == "REJECTED"
      
      # Bulky by length dimension and heavy
      assert PackageSorter.sort(10, 10, 150, 20) == "REJECTED"
      assert PackageSorter.sort(10, 10, 200, 30) == "REJECTED"
    end
    
    test "handles edge cases" do
      # Exactly at the boundaries
      assert PackageSorter.sort(150, 66.67, 99.99, 19.99) == "SPECIAL" # Bulky by dimension, not heavy
      assert PackageSorter.sort(100, 100, 99.99, 20) == "SPECIAL" # Not bulky, but heavy
      assert PackageSorter.sort(150, 66.67, 99.99, 20) == "REJECTED" # Bulky and heavy
      
      # Handle zero or negative values (assuming they're treated as invalid and default to standard)
      assert PackageSorter.sort(0, 0, 0, 0) == "STANDARD"
      assert PackageSorter.sort(-10, 10, 10, 10) == "STANDARD"
      assert PackageSorter.sort(10, -10, 10, 10) == "STANDARD"
      assert PackageSorter.sort(10, 10, -10, 10) == "STANDARD"
      assert PackageSorter.sort(10, 10, 10, -10) == "STANDARD"
    end
    
    test "handles decimal values correctly" do
      # Just below thresholds
      assert PackageSorter.sort(149.99, 99.99, 66.67, 19.99) == "STANDARD"
      
      # Just at or above thresholds
      assert PackageSorter.sort(150.0, 99.99, 66.67, 19.99) == "SPECIAL"
      assert PackageSorter.sort(149.99, 99.99, 66.67, 20.0) == "SPECIAL"
      assert PackageSorter.sort(150.0, 99.99, 66.67, 20.0) == "REJECTED"
    end
  end
end
