# point_mutations.rb

class DNA # :nodoc:
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(comparator)
    size = [@strand.size, comparator.size].min
    (0...size).inject(0) do |distance, nucleotide|
      @strand[nucleotide] == comparator[nucleotide] ? distance : distance + 1
    end
  end
end
