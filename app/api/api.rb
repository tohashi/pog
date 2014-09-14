class API < Grape::API
  prefix 'api'
  format :json

  helpers do
    def current_user
      begin
        User.find(params[:user_id])
      rescue ActiveRecord::RecordNotFound
        {}
      end
    end
  end

  resource :test do
    get '/hello' do
      { hello: 'world' }
    end

    get :hi do
      'hi'
    end
  end

  resource :user do
    desc 'returns all users'
    get do
      User.all
    end

    params do
      requires :user_id, type: Integer
    end

    desc 'returns user'
    route_param :user_id do
      get do
        current_user
      end
    end
  end
end
