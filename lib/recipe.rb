# frozen_string_literal: true

# Class for mapping recipe description
class Recipe
  @@recipes = {}
  attr_reader :name, :ingredients, :method_steps

  def initialize(name:, ingredients: [], method_steps: [])
    return if name.nil?

    @name = name
    @ingredients = ingredients
    @method_steps = method_steps
    @@recipes[name.to_sym] = self
  end

  # method for checking if name is exists and
  # send message nem cannot be empty, when name is nil
  def valid?
    return true unless @name.nil?

    'Name cannot be empty !'
  end

  # sorry i have no ide for clear, it is without databases
  def self.clear; end

  # assign ingredients from description of ingredient
  def ingredient(ingredient_name)
    return if @ingredients.include?(ingredient_name) # handle if duplicate name of ingredient

    @ingredients << ingredient_name
  end

  # evalute the block for method -> steps
  def method(&block)
    instance_eval(&block)
  end

  # after evaluate on method, step is avalable to each
  # adding step_name to method_step variable
  def step(step_name)
    return if @method_steps.include?(step_name) # handle if duplicate step_name

    @method_steps << step_name
  end

  def self.for(name)
    @@recipes[name.to_sym]
  end

  def self.describe(&_)
    yield
  end
end

# create method for handle recipe on description
# evaluate all method from description to recipe (get ingredient and method)
def recipe(name, &block)
  recipe = Recipe.new(name: name)
  recipe.instance_eval(&block)
end
