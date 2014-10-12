include ActionView::Helpers::DateHelper

class API < Grape::API
  prefix 'api'
  format :json

  helpers do
    def session
      env[Rack::Session::Abstract::ENV_SESSION_KEY]
    end

    def current_user
      ApplicationController.check_logined(session)
    end

    # FIXME 命名
    def get_content(name)
      content = Content.find_by(name: name)
      unless content
        content = Content.new(:name => name)
        content.save
      end
      content
    end

    def get_platform_ids(names)
      ids = []
      names.split(',').each do |name|
        name.strip!
        next if name.empty?

        platform = Platform.find_by(name: name)
        unless platform
          platform = Platform.new(:name => name)
          platform.save
          # TODO 失敗時
        end
        ids.push(platform.id)
      end

      ids
    end

    def format_pile(pile)
      platforms = []
      pile.platform_ids.each do |platform_id|
        platforms.push(Platform.find(platform_id))
      end

      pile.attributes.merge({
        'last_updated' => time_ago_in_words(pile.updated_at),
        'content' => pile.content,
        'platforms' => platforms
      })
    end

  end

  resource :user do
    desc 'returns all users'
    get do
      current_user
    end

    params do
      requires :id, type: Integer
    end

    desc 'returns user'
    route_param :id do
      get do
        begin
          User.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          {}
        end
      end
    end
  end

  resource :ranking do
    desc 'returns ranking'
    get do
      Content.get_ranking(Pile.get_content_ids)
    end

    desc 'returns 24h ranking'
    get :day do
      Content.get_ranking(Pile.get_content_ids(86400))
    end
  end

  resource :pile do
    desc 'returns user pile'
    get do
      piles = Pile.where(user_id: current_user.id)
      piles.map {|pile| format_pile(pile)}
    end

    params do
      requires :content_name, type: String
      requires :platform_names, type: String
      requires :status, type: Integer
      optional :memo, type: String
    end

    desc 'create pile'
    post do
      # TODO transaction
      # TODO find_or_create
      content = get_content(params[:content_name])
      platform_ids = get_platform_ids(params[:platform_names])

      new_pile = Pile.new({
        user_id: current_user.id,
        content: content,
        platform_ids: platform_ids,
        memo: params[:memo],
        status: params[:status]
      })

      if new_pile.save
        format_pile(new_pile)
      else
        nil
      end
    end

    params do
      requires :id, type: Integer
      requires :content_name, type: String
      requires :platform_names, type: String
      requires :status, type: Integer
      requires :memo, type: String
    end

    desc 'update pile'
    put ':id' do
      # TODO auth
      pile = Pile.find(params[:id])
      content = get_content(params[:content_name])
      platform_ids = get_platform_ids(params[:platform_names])
      pile_params = {
        content: content,
        platform_ids: platform_ids,
        memo: params[:memo],
        status: params[:status]
      }

      if pile.update(pile_params)
        format_pile(pile)
      else
        nil
      end
    end
  end

  resource :content do

    desc 'returns all contents'
    get do
      Content.all
    end

    params do
      requires :id, type: Integer
    end

    desc 'returns nearly content'
    get 'nearly/:id' do
      Content.get_nearly_contents(params[:id])
    end
  end
end
