require 'rails_helper'

RSpec.describe ImportRecipes do
  let(:recipes_path) { 'spec/fixtures/recipes_xs.json' } # 10 recipes
  let(:subject) { described_class.new(recipes_path) }

  it 'has a default recipes path' do
    expect(described_class.new.recipes_path).to eq(ImportRecipes::DEFAULT_PATH)
  end

  it 'creates as many jobs as recipes' do
    expect {
      subject.call
    }.to change {
      CreateRecipeWorker.jobs.size
    }.by(10)
  end
end
