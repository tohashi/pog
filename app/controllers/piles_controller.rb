class PilesController < ApplicationController
  before_action :set_values

  def index
  end

  def new
    @pile = Pile.new
  end

  def create
    content_name = params[:content_name]
    platform_names = params[:platform_names].split(',')
    params = pile_params

    # TODO transaction
    # TODO find_or_create
    content = Content.find_by(name: content_name)
    unless content
      content = Content.new(:name => content_name)
      content.save
    end

    platform_ids = []
    platform_names.each do |platform_name|
      platform_name.strip!
      next if platform_name.empty?

      platform = Platform.find_by(name: platform_name)
      unless platform
        platform = Platform.new(:name => platform_name)
        platform.save
        # TODO 失敗時
      end
      platform_ids.push(platform.id)
    end

    params[:user_id] = @user.id
    params[:content_id] = content.id
    params[:platform_ids] = platform_ids

    @pile = Pile.new(params)
    if @pile.save
      redirect_to piles_path
    else
      render 'new'
    end
  end

  def edit
    @pile = Pile.find(params[:id])
  end

  def update
    @pile = Pile.find(params[:id])
    if @pile.update(pile_params)
      redirect_to piles_path
    else
      render 'edit'
    end
  end

  def destroy
    @pile = Pile.find(params[:id])
    @pile.destroy
    redirect_to piles_path
  end

  private
    def pile_params
      params[:pile].permit(:memo)
    end

    def set_values
      @piles = Pile.where(user_id: @user.id)
      @content = Content
    end

end
