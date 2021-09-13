require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "6c34649ab05e8758c342b68017259727a10df37f0632b4e964881452f690140241a26e29807ad5b1b10a9b6b701670afe916e61322de5fc392e65124102e9e84"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  post '/login' do
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect to '/account'
    else
      flash[:message] = "Please create an account to log in"
      redirect to '/signup'
    end
  end

end
