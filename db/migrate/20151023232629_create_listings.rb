class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :address
      t.string :date
      t.string :listing_id
      t.string :listing_title
      t.string :price
      t.string :bedrooms
      t.string :square_ft
      t.string :city

      t.timestamps null: false
    end
  end
end
