class ApplicationController < ActionController::Base
# before_action :before_anything_else

  def before_anything_else
    @contributors = GithubFacade.contributors
  end

  def index
  end
  
  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
