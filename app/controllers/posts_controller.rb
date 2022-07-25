# frozen_string_literal: true

class PostsController < ApplicationController

  def create
    @post = Post.new(permitted_params)

    raise "Opa parece que você não escreveu nada aqui, escreva e tente novamente" if @post.body.blank?
    raise "Você precisa estar logado para criar um novo post" if @post.user_id.blank?

    @post.save!

    flash[:success] = "Novo post criado com sucesso"
    redirect_to root_path
  rescue StandardError => e
    flash[:danger] = e.message
    redirect_to root_path
  end

  def like
    raise "Você precisa esta logado para curtir um post" if current_user.blank?

    post = Post.find(params[:id]) rescue nil

    raise "Post não encontrado" if post.nil?

    @like = Like.new(post: post, user: current_user)

    @like.save!

    flash[:success] = "Post curtido com sucesso"
    redirect_to root_path
  rescue StandardError => e
    flash[:danger] = e.message
    redirect_to root_path
  end

  private

  def permitted_params
    params.require(:post).permit(:body, :user_id)
  end
end
