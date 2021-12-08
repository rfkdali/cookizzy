require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let!(:plat_1)    { create(:recipe, name: 'Oeuf au plat')}
  let!(:oeufs) { create(:ingredient, recipe: plat_1, name_qty: '2 Oeufs')}
  let!(:huile) { create(:ingredient, recipe: plat_1, name_qty: '1cs Huile')}

  let!(:plat_2)    { create(:recipe, name: 'Velouté au foie gras')}
  let!(:foie_gras) { create(:ingredient, recipe: plat_2, name_qty: '200grs de Foie gras')}
  let!(:creme) { create(:ingredient, recipe: plat_2, name_qty: '25cl de crème')}

  describe 'pg_search_scope' do
    describe 'search_by_ingredients' do
      describe 'one recipe matching' do
        it 'returns corresponding recipe' do
          expect(Recipe.search_by_ingredients('oeufs')).to eq([plat_1])
        end
      end

      describe 'Two recipes matching' do
        let!(:plat_3) { create(:recipe, name: 'Terrine de foie gras')}
        let!(:foie_gras_2) { create(:ingredient, recipe: plat_3, name_qty: '400grs de Foie gras')}

        it 'returns corresponding recipes' do
          expect(Recipe.search_by_ingredients('foie gras')).to eq([plat_2, plat_3])
        end
      end
    end
  end
end
