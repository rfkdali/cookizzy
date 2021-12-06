require 'rails_helper'

RSpec.describe '/ingredients', type: :request do
  let(:recipe) { create(:recipe) }

  let(:valid_attributes) {
    { recipe_id: recipe.id, name_qty: 'chicken' }
  }
  let(:invalid_attributes) {
    { recipe_id: recipe.id, name_qty: nil}
  }

  let(:ingredient) { create(:ingredient, valid_attributes) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get ingredients_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get ingredient_url(ingredient)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_ingredient_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_ingredient_url(ingredient)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Ingredient' do
        expect {
          post ingredients_url, params: { ingredient: valid_attributes }
        }.to change(Ingredient, :count).by(1)
      end

      it 'redirects to the created ingredient' do
        post ingredients_url, params: { ingredient: valid_attributes }
        expect(response).to redirect_to(ingredient_url(Ingredient.last))
      end
    end

    context 'with invalid parameters' do
      let(:ingredient) { create(:ingredient, valid_attributes) }
      it 'does not create a new Ingredient' do
        expect {
          post ingredients_url, params: { ingredient: invalid_attributes }
        }.to change(Ingredient, :count).by(0)
      end

      it 'returns an error' do
        post ingredients_url, params: { ingredient: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) {
        { recipe_id: recipe.id, name_qty: 'beef' }
      }

      it 'updates the requested ingredient' do
        ingredient = Ingredient.create! valid_attributes
        patch ingredient_url(ingredient), params: { ingredient: new_attributes }
        ingredient.reload
        expect(ingredient.name_qty).to eq(new_attributes[:name_qty])
      end

      it 'redirects to the ingredient' do
        ingredient = Ingredient.create! valid_attributes
        patch ingredient_url(ingredient), params: { ingredient: new_attributes }
        ingredient.reload
        expect(response).to redirect_to(ingredient_url(ingredient))
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        ingredient = Ingredient.create! valid_attributes
        patch ingredient_url(ingredient), params: { ingredient: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested ingredient' do
      ingredient = Ingredient.create! valid_attributes
      expect {
        delete ingredient_url(ingredient)
      }.to change(Ingredient, :count).by(-1)
    end

    it 'redirects to the ingredients list' do
      ingredient = Ingredient.create! valid_attributes
      delete ingredient_url(ingredient)
      expect(response).to redirect_to(ingredients_url)
    end
  end
end
