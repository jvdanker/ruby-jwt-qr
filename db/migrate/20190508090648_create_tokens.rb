class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :description
      t.string :permissions
      t.string :status
      t.string :timeout
      t.string :token

      t.timestamps
    end
  end
end
