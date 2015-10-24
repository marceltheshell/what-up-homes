class CreateFavoriteListings < ActiveRecord::Migration
  def change
    create_table :favorite_listings do |t|
      t.string :email
      t.string :google_id

      t.timestamps null: false
    end
  end
end
