class AddColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :min_age, :integer
    add_column :events, :max_age, :integer
  end
end
