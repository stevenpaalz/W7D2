class NotNullBandName < ActiveRecord::Migration[7.0]
  def change

    change_column_null :bands, :name, false
  end
end
