require 'rails_helper'

RSpec.describe '/recipes', type: :request do
  let(:valid_attributes) {
    { name: 'Roasted chicken' }
  }
  let(:invalid_attributes) {
    { name: nil}
  }
  let(:recipe) { create(:recipe, valid_attributes) }
  let!(:chicken) { create(:ingredient, recipe: recipe, name_qty: '800grs of chicken') }

  describe 'GET /search_by_ingredients' do
    before { post recipes_search_path, params:{name: recipe_name} }

    context 'with existing recipe name' do
      let(:recipe_name) { 'chicken' }
      it 'renders a successful response' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns recipes' do
        expect(json_body[:recipes][0][:name]).to eq(recipe.name)
      end
    end

    context 'with unexisting recipe name' do
      let(:recipe_name) { 'pudding' }
      it 'returns :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns empty array' do
        expect(json_body[:recipes]).to be_empty
      end
    end
  end

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
      delete recipe_url(recipe)
      expect(response).to redirect_to(recipes_url)
    end
  end
end
