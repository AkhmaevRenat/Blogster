# frozen_string_literal: true

require 'rails_helper'

describe Article do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:user) }
  end

  describe 'assotiations' do
    it { is_expected.to have_many(:comments) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:likes) }
  end

  describe '#last_comment' do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    context 'when article has comments' do
      let!(:сomment) { create(:comment, article: article, user: user) }
      let!(:second_сomment) { create(:second_comment, article: article, user: user) }

      it 'returns the last comment' do
        expect(article.last_comment.body).to eq 'Hi and hi'
      end
    end

    context 'when article has no comments' do
      it 'returns nil' do
        expect(article.last_comment).to eq nil
      end
    end
  end

  describe 'article likes' do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    context 'when article has likes' do
      let!(:like) { create(:like, likeable: article, user: user) }

      it 'returns the likes count' do
        expect(article.likes.count).to eq 1
      end
    end

    context 'when article has no likes' do
      it 'returns the likes count' do
        expect(article.likes.count).to eq 0
      end
    end
  end
end
