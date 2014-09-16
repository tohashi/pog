include ActionView::Helpers::DateHelper

class API < Grape::API
  prefix 'api'
  format :json

  helpers do
    def session
      env[Rack::Session::Abstract::ENV_SESSION_KEY]
    end

    def current_user
      if session[:user_id]
        begin
          user = User.find(session[:user_id])
        rescue ActiveRecord::RecordNotFound
          reset_session
        end
      end

      unless user
        user = User.guest.first
      end

      user
    end
  end

  resource :user do
    desc 'returns all users'
    get do
      User.all
    end

    get :current do
      current_user
    end

    params do
      requires :user_id, type: Integer
    end

    desc 'returns user'
    route_param :user_id do
      get do
        begin
          User.find(params[:user_id])
        rescue ActiveRecord::RecordNotFound
          {}
        end
      end
    end
  end

  resource :ranking do
    desc 'returns ranking'
    get do
      Content.get_content_rankings(Pile.get_content_ids)
    end

    desc 'returns 24h ranking'
    get :day do
      Content.get_content_rankings(Pile.get_content_ids(86400))
    end
  end

  resource :pile do

    desc 'returns user pile'
    get do
      user = current_user
      piles = Pile.where(user_id: user.id)

      piles.map do |pile|
        content = Content.find(pile.content_id)
        platforms = []
        pile.platform_ids.each do |platform_id|
          platforms.push(Platform.find(platform_id))
        end

        pile.attributes.merge({
          'last_updated' => time_ago_in_words(pile.updated_at),
          'content' => content,
          'platforms' => platforms
        })
      end
    end


    params do
      requires :content_name, type: String
      requires :platform_names, type: String
      requires :status, type: Integer
      optional :memo, type: String
    end

    post do
      content_name = params[:content_name]
      platform_names = params[:platform_names].split(',')

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

      new_pile = Pile.new({
        user_id: current_user.id,
        content_id: content.id,
        platform_ids: platform_ids,
        memo: params[:memo]
      })

      if new_pile.save
        new_pile
      else
        nil
      end
    end
  end

  resource :content do
    get do
      Content.all
    end
  end
end
