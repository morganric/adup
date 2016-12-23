class AddPriceToWebsite < ActiveRecord::Migration
  def change
    add_column :websites, :price, :float
    add_column :websites, :image, :string
  end
end
