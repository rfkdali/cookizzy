require 'rails_helper'

RSpec.describe "ingredients/new", type: :view do
  before(:each) do
    assign(:ingredient, Ingredient.new(
      name_qty: "MyString",
      recipe: nil
    ))
  end

  it "renders new ingredient form" do
    render

    assert_select "form[action=?][method=?]", ingredients_path, "post" do

      assert_select "input[name=?]", "ingredient[name_qty]"

      assert_select "input[name=?]", "ingredient[recipe_id]"
    end
  end
end
