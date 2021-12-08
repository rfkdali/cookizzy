require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:ingredients_1) { '2 Oeufs, 1cs Huile' }
  let!(:plat_1)       { create(:recipe, name: 'Oeuf au plat', ingredients: ingredients_1)}

  let(:ingredients_2) { '200grs de Foie gras, 25cl de crème' }
  let!(:plat_2)       { create(:recipe, name: 'Velouté au foie gras', ingredients: ingredients_2)}

  describe 'pg_search_scope' do
    describe 'search_by_ingredients' do
      describe 'one recipe matching' do
        it 'returns corresponding recipe' do
          expect(Recipe.search_by_ingredients('oeufs')).to eq([plat_1])
        end
      end

      describe 'Two recipes matching' do
        let(:ingredients_3) { '400grs de Foie gras, 25cl de crème' }
        let!(:plat_3)       { create(:recipe, name: 'Velouté au foie gras', ingredients: ingredients_3)}
        it 'returns corresponding recipes' do
          expect(Recipe.search_by_ingredients('foie gras')).to eq([plat_2, plat_3])
        end
      end
    end
  end
end
