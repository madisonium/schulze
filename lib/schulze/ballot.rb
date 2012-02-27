require 'matrix'

module Schulze
  class Ballot
    def self.new_from_filename filename
      new.tap do |ballot|
        File.open(filename, 'r') do |io|
          io.each_line do |line|
            chunks = line.split
            ballot.add_choice(chunks.first.to_i, chunks.last)
          end
        end
      end
    end

    def initialize
      @choices = Hash.new(1e9)
    end

    def add_choice ordering, name
      @choices[name] = ordering
    end

    def candidates
      @choices.keys
    end

    def preference_matrix all_candidates
      matrix = Matrix.zero(all_candidates.size)
      Matrix.build(all_candidates.size) do |row, col|
        if row == col
          0
        else
          a, b = all_candidates[row], all_candidates[col]
          prefers?(a, b) ? 1 : 0
        end
      end
    end

    def prefers? a, b
      @choices[a] < @choices[b]
    end

    def to_s
      "Ballot:\n" + @choices.to_a.map(&:inspect).join("\n")
    end

  end
end
