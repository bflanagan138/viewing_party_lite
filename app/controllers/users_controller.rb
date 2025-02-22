# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @movies = @user.viewing_parties.map do |vp|
      MovieFacade.movie_details(vp.movie_id)
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user)
      flash[:alert] = 'User Created Successfully'
    else
      redirect_to register_path
      flash[:alert] = user.errors.full_messages.to_sentence
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
