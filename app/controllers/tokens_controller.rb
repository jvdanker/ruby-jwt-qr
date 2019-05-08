require 'jwt'

class TokensController < ApplicationController

  # This function is an example implementation to validate an incoming POST-request
  # for a new application.
  # This method should validate the following:
  # - make sure the token is valid by decoding it
  # - has the correct status 'active' and not 'revoked' or 'inactive'
  def validate
    # validate uses the tokenid to fetch the token, but in a 'live' environment
    # the token should be fetched from the db using the 'token' string instead of an ID
    @token = Token.find(params[:id])

    # just an example, hmac secret should be at least 256 bits
    hmac_secret = 'my$ecretK3y'
    begin
      decoded_token = JWT.decode @token.token, hmac_secret, true, { algorithm: 'HS256' }

      if decoded_token[0]["per"] == 'submit_application'
        flash[:notice] = "valid token"
      else
        flash[:notice] = "valid token, but no permission to perform action"
      end

      # make sure the token isn't revoked or inactive
      if @token.status == 'revoked'
        flash[:notice] = "invalid token, token revoked"
      end

      if @token.status == 'inactive'
        flash[:notice] = "invalid token, token inactive"
      end
    rescue JWT::ExpiredSignature
      flash[:notice] = "token expired"
    end

    redirect_to tokens_path
  end

  def index
    @tokens = Token.all
  end

  def show
    @token = Token.find(params[:id])

    begin
      hmac_secret = 'my$ecretK3y'
      decoded_token = JWT.decode @token.token, hmac_secret, true, { algorithm: 'HS256' }

      flash[:notice] = decoded_token
    rescue JWT::ExpiredSignature
      flash[:notice] = "token expired"
    end
  end

  # this will create a token that is valid for 2 minutes and only allows you to use it for submitting applications
  def new
    @token = Token.new
    @token.status = 'inactive'
    @token.permission = 'submit_application'
    @token.expiration = Time.now.to_i + 120
  end

  def create
    token = Token.create(token_params)
    redirect_to tokens_path
  end

  def edit
    @token = Token.find(params[:id])
  end

  def update
    @token = Token.find(params[:id])
    @token.update(token_params)
    redirect_to tokens_path
  end

  def revoke
    @token = Token.find(params[:id])
    @token.status = 'revoked'
    @token.save
    redirect_to tokens_path
  end

  def activate
    @token = Token.find(params[:id])
    @token.status = 'active'
    @token.save
    redirect_to tokens_path
  end

  def destroy
    @token = Token.find(params[:id])
    @token.destroy

    redirect_to tokens_path
  end

  private

  def token_params
    params.require(:token). permit(:description, :expiration, :status, :permission, :token)
  end
end
