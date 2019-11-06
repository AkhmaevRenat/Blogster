# frozen_string_literal: true

require 'rails_helper'

describe Likes::LikeManagement do
  let(:like_management_command) { described_class.new }

  describe '#call' do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    context 'when likeable_type is Article' do
      let(:like_management) do
        like_management_command.call(
          likeable_type: article.class.name,
          likeable_id: article.id,
          user: user
        )
      end

      context 'when article not liked by user' do
        it 'like added' do
          like_management
          expect(article.reload.likes_count).to eq(1)
        end
      end

      context 'when article was already liked by user' do
        before do
          create(:like, likeable_type: article.class.name, likeable_id: article.id, user: user)
          article.reload.likes_count += 1
          article.save!
        end

        it 'removes like' do
          like_management
          expect(article.reload.likes_count).to eq(0)
        end
      end
    end

    context 'when likeable_type is Comment' do
      let(:comment) { create(:comment, article: article, user: user) }
      let(:like_management) do
        like_management_command.call(
          likeable_type: comment.class.name,
          likeable_id: comment.id,
          user: user
        )
      end

      context 'when comment not liked by user' do
        it 'like added' do
          like_management
          expect(comment.reload.likes_count).to eq(1)
        end
      end

      context 'when comment was already liked by user' do
        before do
          create(:like, likeable_type: comment.class.name, likeable_id: comment.id, user: user)
          comment.reload.likes_count += 1
          comment.save!
        end

        it 'removes like' do
          like_management
          expect(article.reload.likes_count).to eq(0)
        end
      end
    end
  end
end
