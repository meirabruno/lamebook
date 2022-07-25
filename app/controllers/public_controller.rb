# frozen_string_literal: true

class PublicController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc)
    @post = Post.new
  end
end
