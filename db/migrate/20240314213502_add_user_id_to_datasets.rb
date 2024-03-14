class AddUserIdToDatasets < ActiveRecord::Migration[7.0]
  def change
    add_reference :datasets, :user, null: false, foreign_key: true
  end
end
