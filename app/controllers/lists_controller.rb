class ListsController < ApplicationController
  before_action :set_list, only: [:show]
  # before_action :set_list, only: [:show, :destroy]

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    # receiving the params from the form
    @list = List.new(list_params)
    if @list.save
      # redirect to the show page
      redirect_to list_path(@list) # lists#show
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    # As a user, I can see the details of a movie list:
    # pra mostrar, primeiro a gente tem que saber o que vai mostrar. buscar id no params
    # MAS: a lista tá no private method set_list - que será então triggered pelo before_action
    # só na ação show (posteriorimente tb na delete)
    # então, quando show for chamado, @list já vai estar lá

    # As a user, I can bookmark a movie inside a movie list
    # we create a new instance in order to create the form in the show page
    @bookmark = Bookmark.new(list: @list)
      #                     here we state that bookmark belongs to the list we are showing

    # @review = Review.new(list: @list)
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
