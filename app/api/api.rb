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
  end

  resource :content do
    get do
      Content.all
    end
  end
end
