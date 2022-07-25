# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PublicController, type: :controller do
  describe 'GET #index' do
    context 'list posts' do
      let!(:user) { create(:user) }
      let!(:post) { create(:post, user: user) }

      it 'returns a successful response' do
        get :index
        expect(response).to be_successful
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template('index')
      end

      it 'assigns @posts' do
        get :index
        expect(assigns(:posts)).to eq([post])
      end
    end
  end
end
