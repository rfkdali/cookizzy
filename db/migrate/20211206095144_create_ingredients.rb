class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :name_qty
      t.references :recipe, index: true, foreign_key: {on_delete: :cascade}

      t.timestamps
    end
  end
end
