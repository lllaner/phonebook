class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.references :telephone_book, null: false, foreign_key: true
      t.index %i[telephone_book_id phone], unique: true
      t.timestamps
    end
  end
end
