class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  def index
    @q = current_user.todos.ransack(params[:q])
    @todos = @q.result(distinct: true)
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

    if params[:back].present?
      render :new
      return
    end

    if @todo.save
      SampleJob.perform_later
      redirect_to @todo, notice: "Todo #{@todo.name} を登録しました"
    else
      render :new
    end
  end

  def destroy
    todo = current_user.todos.find(params[:id])
    todo.destroy
    redirect_to todos_url, notice: "Todo #{todo.name} を削除しました"
  end

  def confirm_new
    @todo = current_user.todos.new(todo_params)
    render :new unless @todo.valid?
  end

  private
  def todo_params
    params.require(:todo).permit(:name, :description, :image)
  end

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end
end
