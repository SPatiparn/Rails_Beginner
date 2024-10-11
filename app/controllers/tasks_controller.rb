class TasksController < ApplicationController
    def index
        @tasks = Task.where(status: :incomplete)
        @new_task = Task.new
    end
      
    def create
        @task = Task.new(task_params)
        @task.status = :incomplete
        if @task.save
          redirect_to tasks_path, notice: 'Task was successfully created.'
        else
          render :index
        end
    end
      
    def complete
        @task = Task.find(params[:id])
        if @task.update(status: :complete)
          redirect_to tasks_path, notice: 'Task was successfully marked as complete.'
        else
          redirect_to tasks_path, alert: 'Failed to mark the task as complete.'
        end
    end
    
    def show  # เพิ่มฟังก์ชันนี้
        @task = Task.find(params[:id])
    end
      
    private
      
    def task_params
        params.require(:task).permit(:title)
    end
end