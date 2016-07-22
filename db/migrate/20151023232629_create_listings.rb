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
      t.string :state
      t.string :cl_region
      t.string :zip_code
      t.float :latitude
      t.float :longitude


      t.timestamps null: false
    end
  end
end
