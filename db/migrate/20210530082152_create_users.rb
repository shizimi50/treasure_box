class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :email, :null => false
      t.string :photo_path, default: "/uploads/user/photo_path/default_user.jpg"
      t.string :password_digest, :null => false #暗号化されたパスワード

      t.timestamps
    end
    add_index :users, :email, unique: true

  end
end
