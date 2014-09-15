class TodoItemsController < ApplicationController
	#review before_action
	before_action :set_todo_item, only: [:show, :update, :destroy]
  # create a before_action that just returns the template
  #   without the layout
  before_action :render_main_layout_if_format_html

  respond_to :json, :html

	def index
		respond_with (@todo_items = TodoItem.all)
	end

	def create
		respond_with TodoItem.create(todo_params) #created as todoItem originally, but in database shows up as todo_items?? #review
	end

	def show  #what is point of show? #review
		respond_with @todo_item
	end

	def update
		respond_with @todo_item.update(todo_params)
	end

	def destroy
		respond_with @todo_item.destroy
	end

	private #why is this private here? #reivew
  def set_todo_item
    @todo_item = TodoItem.find(params[:id]) #refactoring which sets @todo_item as the instance of the item where you find by id
  end

	def render_main_layout_if_format_html
    # check the request format
    if request.format.symbol == :html
      render "layouts/application"
    end
  end

  def todo_params
    params.require(:todo_item).permit(:description, :completed)
  end
end
