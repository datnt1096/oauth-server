class CreateOauthApps < ActiveRecord::Migration[5.2]
  def change
    create_table :oauth_apps, id: :uuid do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :home_page, null: false
      t.string :secret_key, null: false
      t.text :description
      t.string :callback_url, null: false
      t.string :token
      t.datetime :token_created_at

      t.timestamps
    end
  end
end
