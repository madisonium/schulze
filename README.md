# Schulze

Calculate the winner of a Schulze method election.

This gem is intended for command-line use, though it may work alright as a library.

## Warning!

This program was designed against a particular use-case... specifically, candidates must have unique last names (where last name is defined as the last element of a `split`). This was done because data on first names tends to be unclean (e.g., "Tim" & "Timothy" are the same person).

## Installation

Install it:

    $ gem install schulze

## Usage

Collect ballots in a directory. Each ballot should be a file in the form:

    1 A
    2 B
    3 C1
    3 C2
    4 D

Then, run the program:

    $ schulze directory/to/ballots/*.txt

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
