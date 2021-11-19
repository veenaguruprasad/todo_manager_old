class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render "index"
  end

  def show
    id = params[:id]
    render plain: Todo.find(id).to_displayable_string
  end

  def update
    id = params[:id]
    completed = params[:completed]
    todo = Todo.find(id)
    todo.completed = completed
    todo.save!
    text = "Update todo completed status to #{completed}"
    render plain: text
  end

  def create
    text = params[:todo_text]
    date = DateTime.parse(params[:due_date])
    todo = Todo.create!(todo_text: text, due_date: date, completed: false)
    render plain: "Hey, Your new todo is created with the id #{todo.id}!"
  end
end
