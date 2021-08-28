class CreateAdvertisements < ActiveRecord::Migration[6.1]
  def change
    create_table :advertisements do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.string :action_text
      t.string :action_url
      t.boolean :published

      t.timestamps
    end
  end
end
