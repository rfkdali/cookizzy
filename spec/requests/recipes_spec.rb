require 'rails_helper'

RSpec.describe '/recipes', type: :request do
  let(:valid_attributes) {
    { name: 'Roasted chicken' }
  }
  let(:invalid_attributes) {
    { name: nil}
  }
  let(:recipe) { create(:recipe, valid_attributes) }

  describe 'GET /index' do
    it 'renders a successful response' do
      get recipes_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get recipe_url(recipe)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_recipe_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_recipe_url(recipe)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Recipe' do
        expect {
          post recipes_url, params: { recipe: valid_attributes }
        }.to change(Recipe, :count).by(1)
      end

      it 'redirects to the created recipe' do
        post recipes_url, params: { recipe: valid_attributes }
        expect(response).to redirect_to(recipe_url(Recipe.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Recipe' do
        expect {
          post recipes_url, params: { recipe: invalid_attributes }
        }.to change(Recipe, :count).by(0)
      end

      it 'returns an error' do
        post recipes_url, params: { recipe: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) {
        { recipe_id: recipe.id, name: 'Roasted beef' }
      }

      it 'updates the requested recipe' do
        patch recipe_url(recipe), params: { recipe: new_attributes }
        recipe.reload
        expect(recipe.name).to eq(new_attributes[:name])
      end

      it 'redirects to the recipe' do
        recipe = Recipe.create! valid_attributes
        patch recipe_url(recipe), params: { recipe: new_attributes }
        recipe.reload
        expect(response).to redirect_to(recipe_url(recipe))
      end
    end

    context 'with invalid parameters' do
      it 'returns an error' do
        recipe = Recipe.create! valid_attributes
        patch recipe_url(recipe), params: { recipe: invalid_attributes }
        expect(response).to be_unprocessable
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested recipe' do
      recipe = Recipe.create! valid_attributes
      expect {
        delete recipe_url(recipe)
      }.to change(Recipe, :count).by(-1)
    end

    it 'redirects to the recipes list' do
      recipe = Recipe.create! valid_attributes
      delete recipe_url(recipe)
      expect(response).to redirect_to(recipes_url)
    end
  end
end