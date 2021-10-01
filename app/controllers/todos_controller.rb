class TodosController < ApplicationController
    skip_before_action :verify_authenticity_token
  
    def index
      render plain: Todo.to_displayable_list.join("\n")
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
      txt = "Update todo completed status to #{completed}"
      render plain: txt
    end
  
    def create
      txt = params[:todo_text]
      date = DateTime.parse(params[:due_date])
      item = Todo.create!(todo_text: txt, due_date: date, completed: false)
      render plain: "Hey, Your new todo is created with the id #{item.id}!"
    end
end
