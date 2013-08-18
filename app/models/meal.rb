class Meal < ActiveRecord::Base
  attr_accessible :date, :calories, :carbohydrates, :fat, :protein, :description

  validates_presence_of :date, :calories
  validates_numericality_of :calories
  validates_numericality_of :carbohydrates, :fat, :protein, allow_nil: true

  belongs_to :user

  MACRO_NUTRIENTS = %w(carbohydrates fat protein)

  def self.macro_nutrients
    MACRO_NUTRIENTS
  end

  def unit
    "grams"
  end

  def carbohydrates_percentage
    return if carbohydrates.nil?
    percentage(:carbohydrates).round(1)
  end

  def fat_percentage
    return if fat.nil?
    percentage(:fat).round(1)
  end

  def protein_percentage
    return if protein.nil?
    percentage(:protein).round(1)
  end

  private

  def percentage nutrient
    sum = 0
    Meal.macro_nutrients.each do |macro_nutrient|
      sum += self.send(macro_nutrient.to_sym)
    end
    self.send(nutrient).to_f / sum * 100
  end

end
