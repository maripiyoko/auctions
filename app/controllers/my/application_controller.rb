class My::ApplicationController < ApplicationController
  before_action :authenticate_user!

  layout 'my_application'
end
