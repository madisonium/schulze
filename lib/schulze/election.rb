require File.expand_path('../ballot', __FILE__)
require 'set'

module Schulze
  class Election

    def self.perform_for_dir_glob dir_glob
      election = new
      dir_glob.each do |filename|
        election << Ballot.new_from_filename(filename)
      end
      election.results
    end

    def initialize
      @ballots = []
      @candidates = Set.new
    end

    def << ballot
      @ballots << ballot
      @candidates.merge ballot.candidates
    end

    def results
      candidate_array = @candidates.to_a.sort
      pairwise = generate_pairwise_preferences candidate_array
      path_strengths = generate_path_strengths pairwise

      if !(defined?(SILENCE) && SILENCE)
        path_strengths.each_with_index do |row, idx|
          puts("%20s %s" % [candidate_array[idx], row.inspect])
        end
      end

      generate_orderings candidate_array, path_strengths
    end

    private

    def generate_pairwise_preferences candidates
      @ballots.inject(::Matrix.zero(@candidates.count)) do |memo, ballot|
        memo + ballot.preference_matrix(candidates)
      end
    end

    def generate_path_strengths d
      size = d.row_size
      paths = Matrix.build(size) do |row, col|
        if row == col
          0
        else
          d[row,col] > d[col,row] ? d[row,col] : 0
        end
      end
      ret = d.to_a
      0.upto(size-1) do |i|
        0.upto(size-1) do |j|
          unless i == j
            0.upto(size-1) do |k|
              if i != k && j != k
                ret[j][k] = [ret[j][k], [ret[j][i], ret[i][k]].min].max
              end
            end
          end
        end
      end
      ret
    end

    def generate_orderings candidate_array, path_strengths
      sorted = candidate_array.sort do |a, b|
        i, j = candidate_array.index(a), candidate_array.index(b)
        path_strengths[j][i] <=> path_strengths[i][j]
      end
      ret = [[sorted.shift]]
      while not sorted.empty?
        last_addition = ret.last.last
        next_candidate = sorted.shift
        i, j = candidate_array.index(last_addition), candidate_array.index(next_candidate)
        if path_strengths[i][j] == path_strengths[j][i]
          ret.last << next_candidate
        else
          ret << [next_candidate]
        end
      end
      ret
    end

  end
end
