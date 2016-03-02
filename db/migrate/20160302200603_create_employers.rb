class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :login
      t.string :password_hash
      t.string :password_salt
      t.text :company_name
      t.string :telephone
      t.text :address

      t.timestamps null: false
    end
  end
end
