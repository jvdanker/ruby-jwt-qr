class TokensController < ApplicationController
  def index
    @tokens = Tokens.all
  end

  def show
  end

  def new
  end

  def edit
  end
end
