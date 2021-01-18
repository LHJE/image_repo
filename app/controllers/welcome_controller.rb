class WelcomeController < ApplicationController
  def index
    @images = Image.all.reverse
  end
end
