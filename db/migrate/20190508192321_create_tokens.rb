class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :description
      t.string :expiration
      t.string :status
      t.string :token
      t.string :permission

      t.timestamps
    end
  end
end
