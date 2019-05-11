class TodosController < ApplicationController
  def index
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def edit
  end

  def create
    todo = Todo.new(todo_params)
    todo.save!
    redirect_to todos_url, notice: "Todo #{todo.name} を登録しました"
  end

  private
  def todo_params
    params.require(:todo).permit(:name, :description)
  end
end
