# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @movies = MovieFacade.discover_movie(params[:q])
  end

  def show
    @user = User.find(params[:user_id])
    @movie = MovieFacade.movie_details(params[:id])
    @actors = MovieFacade.actors(params[:id])
    @reviews = MovieFacade.review_details(params[:id])
  end
end
