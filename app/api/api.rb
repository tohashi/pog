class API < Grape::API
  prefix 'api'
  format :json

  helpers do
  end

  resource :test do
    get '/hello' do
      { hello: "world" }
    end

    get :hi do
      "hi"
    end
  end

  resource :user do
    get '1' do
      User.first
    end
  end
end
