class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    ind = id
    status = completed ? "[X]" : "[ ]"
    date_status = due_today? ? "" : due_date
    "#{ind}. #{status} #{todo_text} #{date_status}"
  end

  def self.overdue
    where("due_date < ?", Date.today)
  end

  def self.due_today
    where(due_date: Date.today)
  end

  def self.due_later
    where("due_date > ?", Date.today)
  end

  def self.completed
    where(completed: true)
  end

  def self.to_displayable_list
    all.map { |todo| todo.to_displayable_string }
  end

  def self.add_task(mytask)
    Todo.create!(todo_text: mytask[:todo_text], due_date: Date.today + mytask[:due_in_days], completed: false)
  end

  def self.mark_as_complete(id)
    todo = find_by(id: id)
    todo.completed = true
    todo.save
    todo
  end

  def self.show_list
    puts "My Todo-list\n\n"
    puts "Overdue\n"
    puts overdue.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    puts "Due Today\n"
    puts due_today.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    puts "Due Later\n"
    puts due_later.map { |todo| todo.to_displayable_string }
    puts "\n"
  end
end
