require 'rails_helper'

RSpec.describe "ingredients/show", type: :view do
  before(:each) do
    @ingredient = assign(:ingredient, Ingredient.create!(
      name_qty: "Name Qty",
      recipe: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name Qty/)
    expect(rendered).to match(//)
  end
end
