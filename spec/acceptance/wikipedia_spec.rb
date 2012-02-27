# See: http://en.wikipedia.org/w/index.php?title=User:MarkusSchulze/Schulze_method_examples&oldid=383750275

require 'schulze'
require 'fileutils'

SILENCE = true

describe 'schulze voting method' do
  let(:tmp_dir) { '/tmp/schulze' }
  let(:candidate_count) { ballots.keys.first.length }

  after do
    FileUtils.rm_rf(tmp_dir)
  end

  before do
    FileUtils.mkdir(tmp_dir)

    ballots.each_pair do |ordering, count|
      1.upto(count) do |idx|
        File.open("#{tmp_dir}/#{ordering}.#{idx}.txt", 'w') do |f|
          pairs = (1..candidate_count).zip(ordering.split(''))
          f.puts pairs.map{|x| "#{x[0]} #{x[1]}"}.join("\n")
        end
      end
    end

  end




  shared_examples_for 'standard schulze' do
    it 'works' do
      result = Schulze::Election.perform_for_dir_glob Dir["#{tmp_dir}/*.txt"]
      result.should == expected
    end
  end




  describe 'example 1' do
    let(:ballots) { {
        'ACBED' => 5,
        'ADECB' => 5,
        'BEDAC' => 8,
        'CABED' => 3,
        'CAEBD' => 7,
        'CBADE' => 2,
        'DCEBA' => 7,
        'EBADC' => 8
      }
    }
    let(:expected) { [['E'], ['A'], ['C'], ['B'], ['D']] }
    it_should_behave_like 'standard schulze'
  end

  describe 'example 2' do
    let(:ballots) { {
        'ACBD' => 5,
        'ACDB' => 2,
        'ADCB' => 3,
        'BACD' => 4,
        'CBDA' => 3,
        'CDBA' => 3,
        'DACB' => 1,
        'DBAC' => 5,
        'DCBA' => 4
      }
    }
    let(:expected) { [['D'], ['A'], ['C'], ['B']] }
    it_should_behave_like 'standard schulze'
  end

  describe 'example 3' do
    let(:ballots) { {
        'ABDEC' => 3,
        'ADEBC' => 5,
        'ADECB' => 1,
        'BADEC' => 2,
        'BDECA' => 2,
        'CABDE' => 4,
        'CBADE' => 6,
        'DBECA' => 2,
        'DECAB' => 5
      }
    }
    let(:expected) { [['B'], ['A'], ['D'], ['E'], ['C']] }
    it_should_behave_like 'standard schulze'
  end

  describe 'example 4', :pending => 'does not handle degenerate cases well' do
    let(:ballots) { {
        'ABCD' => 3,
        'DABC' => 2,
        'DBCA' => 2,
        'CBDA' => 2
      }
    }
    let(:expected) { [['B'], ['C'], ['D'], ['A']] }
    it_should_behave_like 'standard schulze'
  end

end
