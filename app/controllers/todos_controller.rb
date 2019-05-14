class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  def index
    @todos = current_user.todos.order(created_at: :desc)
  end

  def show
    @todo = current_user.todos.find(params[:id])
  end

  def new
    @todo = Todo.new
  end

  def edit
    @todo = current_user.todos.find(params[:id])
  end

  def update
    todo = current_user.todos.find(params[:id])
    todo.update!(todo_params)
    redirect_to todos_url, notice: "Todo #{todo.name} を更新しました"
  end

  def create
    @todo = current_user.todos.new(todo_params)

    if @todo.save
      redirect_to @todo, notice: "Todo #{todo.name} を登録しました"
    else
      render :new
    end
  end

  def destroy
    todo = current_user.todos.find(params[:id])
    todo.destroy
    redirect_to todos_url, notice: "Todo #{todo.name} を削除しました"
  end

  private
  def todo_params
    params.require(:todo).permit(:name, :description)
  end

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end
end
