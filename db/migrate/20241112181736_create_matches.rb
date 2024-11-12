class CreateMatches < ActiveRecord::Migration[8.0]
  def change
    create_table :matches do |t|
      t.string :team_a
      t.string :team_b
      t.integer :goals_team_a
      t.integer :goals_team_b

      t.timestamps
    end
  end
end
