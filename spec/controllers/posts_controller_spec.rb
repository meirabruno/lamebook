# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'POST #create' do
    let!(:user) { create(:user) }

    context 'successful' do
      it 'create a new post' do
        expect do
          post :create, params: { post: {
                                  user_id: user.id,
                                  body: Faker::Lorem.paragraph
                                }
                              }
        end.to change(Post, :count).by(1)
      end

      it 'redirect to root and show flash message' do
        post :create, params: { post: {
                                  user_id: user.id,
                                  body: Faker::Lorem.paragraph
                                }
                              }

        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to eq("Novo post criado com sucesso")
      end
    end

    context 'unsuccessful' do
      it 'whitout body' do
        post :create, params: { post: {
                                  user_id: user.id,
                                  body: nil
                                }
                              }

        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq("Opa parece que você não escreveu nada aqui, escreva e tente novamente")
      end

      it 'whitout body' do
        post :create, params: { post: {
                                  user_id: nil,
                                  body: Faker::Lorem.paragraph
                                }
                              }

        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq("Você precisa estar logado para criar um novo post")
      end
    end
  end

  describe 'GET #like' do
    let!(:user) { create(:user) }
    let!(:post) { create(:post) }

    context 'successful' do
      before { allow(controller).to receive(:current_user) { user } }

      it 'create a new like' do
        expect do
          get :like, params: { id: post }
        end.to change(Like, :count).by(1)
      end

      it 'redirect to root and show flash message' do
        get :like, params: { id: post }

        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to eq("Post curtido com sucesso")
      end
    end

    context 'unsuccessful' do
      it 'whitout post' do
        allow(controller).to receive(:current_user) { user }
        get :like, params: { id: nil }

        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to eq("Post não encontrado")
      end
    end
  end
end
