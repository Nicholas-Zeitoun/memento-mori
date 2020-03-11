class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :style_guide]

  def home
  end

  def style_guide
  end

  def dashboard_template
    @meme = Meme.first
    @memes = Meme.all
    @collect = Collect.new
  end
end
