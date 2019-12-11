class CreateAuthorizations < ActiveRecord::Migration[5.2]
  def change
    create_table :authorizations do |t|
      t.references :user, foreign_key: true
      t.references :oauth_app, foreign_key: true, type: :uuid
      t.string :authorize_code
      t.string :token
      t.string :token_created_at

      t.timestamps
    end
  end
end
