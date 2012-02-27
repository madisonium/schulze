require 'schulze/ballot'
require 'set'
require 'matrix'

describe Schulze::Ballot do
  describe 'preference_matrix' do
    example '4 candidates, 4 choices' do
      expected = ::Matrix[[0, 1, 1, 1], [0, 0, 1, 1], [0, 0, 0, 1], [0, 0, 0, 0]]
      ballot = Schulze::Ballot.new
      ballot.add_choice 1, 'A'
      ballot.add_choice 2, 'B'
      ballot.add_choice 3, 'C'
      ballot.add_choice 4, 'D'
      result = ballot.preference_matrix %w(A B C D)
      result.should == expected
    end
    example '4 candidates, 1 choice' do
      expected = ::Matrix[[0, 1, 1, 1], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]
      ballot = Schulze::Ballot.new
      ballot.add_choice 1, 'A'
      result = ballot.preference_matrix %w(A B C D)
      result.should == expected
    end
  end
end
