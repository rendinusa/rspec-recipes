# frozen_string_literal: true

require_relative '../lib/recipe'

describe Recipe do
  before do
    Recipe.clear

    Recipe.describe do
      recipe 'Pancake' do
        ingredient 'Store-bought pancake mix'
        ingredient 'Water'

        method do
          step 'Mix the ingredients'
          step 'Cook them in a pan'
        end
      end

      recipe 'Miso Soup' do
        ingredient 'Tofu'
        ingredient 'White miso paste'

        method do
          step 'Mix miso paste into boiling water'
          step 'Add tofu and serve'
        end
      end

      recipe 'Banan Split' do
        ingredient 'Banana'
        ingredient 'Vanila Ice Cream'
        ingredient 'Chocolate Ice Cream'
        ingredient 'Banana'

        method do
          step 'Blend banana with ice cream'
          step 'Add some topings and serve'
        end
      end
    end
  end

  it 'records the ingredients and method of each recipe' do
    pancake_recipe = Recipe.for('Pancake')

    expect(pancake_recipe.name).to eq 'Pancake'
    expect(pancake_recipe.ingredients).to eq ['Store-bought pancake mix', 'Water']
    expect(pancake_recipe.method_steps).to eq ['Mix the ingredients', 'Cook them in a pan']

    soup_recipe = Recipe.for('Miso Soup')

    expect(soup_recipe.name).to eq 'Miso Soup'
    expect(soup_recipe.ingredients).to eq ['Tofu', 'White miso paste']
    expect(soup_recipe.method_steps).to eq ['Mix miso paste into boiling water', 'Add tofu and serve']
  end

  it 'remove duplicate ingredient' do
    banana_recipe = Recipe.for('Banan Split')

    expect(banana_recipe.name).to eq 'Banan Split'
    expect(banana_recipe.ingredients).to eq ['Banana', 'Vanila Ice Cream', 'Chocolate Ice Cream']
    expect(banana_recipe.method_steps).to eq ['Blend banana with ice cream', 'Add some topings and serve']
  end

  it 'valid when name assigned' do
    empty_recipe = Recipe.new(name: 'Sunny side up')
    expect(empty_recipe.valid?).to eq true
  end

  it 'validate when name is empty' do
    empty_recipe = Recipe.new(name: nil)
    expect(empty_recipe.valid?).to eq 'Name cannot be empty !'
  end
end
