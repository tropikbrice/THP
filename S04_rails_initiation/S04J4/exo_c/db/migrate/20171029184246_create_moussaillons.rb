class CreateMoussaillons < ActiveRecord::Migration[5.1]
  def change
    create_table :moussaillons do |t|
      t.string :username
      t.string :email
      t.text :bio

      t.timestamps
    end
  end
end
