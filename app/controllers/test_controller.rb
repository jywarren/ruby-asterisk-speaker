class TestController < ApplicationController  

  def index
    render :text => Googlenews.short(2)
  end

end