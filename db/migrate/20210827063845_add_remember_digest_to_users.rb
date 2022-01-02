class AddRememberDigestToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :remember_digest, :string # 記憶ダイジェストはユーザーが直接読み出すことはない（そうさせてはならない）ため、インデックスを追加する必要はない
  end
end
