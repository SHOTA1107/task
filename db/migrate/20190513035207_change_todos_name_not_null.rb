class ChangeTodosNameNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :todos, :name, false
  end
end
