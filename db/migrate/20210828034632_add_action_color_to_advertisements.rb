class AddActionColorToAdvertisements < ActiveRecord::Migration[6.1]
  def change
    add_column :advertisements, :action_color, :string
  end
end
