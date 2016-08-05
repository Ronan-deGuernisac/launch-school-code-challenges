# kindergarten_garden.rb

class Garden # :nodoc:
  DEFAULT_KIDS = %w(
    Alice Bob Charlie David
    Eve Fred Ginny Harriet
    Ileana Joseph Kincaid Larry
  ).freeze

  SEED_PLANT_MAP = {
    'C' => :clover,
    'G' => :grass,
    'R' => :radishes,
    'V' => :violets
  }.freeze

  def initialize(seeds, kids = DEFAULT_KIDS)
    @plants = seeds.split.map(&:chars).map { |row| seed_to_plant(row) }
    @kids = kids.sort.map(&:downcase)
    @gardens = assign_gardens
  end

  def method_missing(method_name)
    name = method_name.to_s
    super unless @gardens.key?(name)
    @gardens[name]
  end

  private

  def seed_to_plant(row)
    row.map { |seed| seed.gsub!(/[A-Z]/, SEED_PLANT_MAP).to_sym }
  end

  def assign_gardens
    gardens = {}
    row_1, row_2 = @plants
    @kids.each do |kid|
      gardens[kid] = row_1.shift(2) + row_2.shift(2)
    end
    gardens
  end
end
