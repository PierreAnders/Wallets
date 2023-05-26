class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:home, :nft, :transaction, :privacy]
  
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

end
