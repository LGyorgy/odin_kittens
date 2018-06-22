class KittensController < ApplicationController
  
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render json: @kittens.to_json }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

     respond_to do |format|
      format.html
      format.json { render json: @kitten.to_json }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.create(kitten_params)
    if @kitten.save
      flash[:success] = "Kitten created! Yey!"
      redirect_to @kitten
    else
      flash.now[:error] = "Kitten data invalid :("
      render 'kittens/new'
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes(kitten_params)
      flash[:success] = "Kitten updated! Yey!"
      redirect_to @kitten
    else
      flash.now[:error] = "Kitten data invalid :("
      render 'kittens/edit'
    end
  end

  def destroy
    Kitten.delete(params[:id])
    flash[:success] = "Kitten destroyed... yey? D:"
    redirect_to root_path
  end

  private
    def kitten_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
