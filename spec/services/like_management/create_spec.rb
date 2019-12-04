# frozen_string_literal: true

require 'rails_helper'

describe LikeManagement::Create do
  let(:create_like_command) { described_class.new }

  describe '#call' do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    context 'when likeable_type is Article' do
      let(:like) do
        create_like_command.call(
          likeable_object: article,
          user: user
        )
      end

      context 'when article not liked by user' do
        it 'like added' do
          expect { like }.to change { article.reload.likes_count }.by(1)
        end
      end
    end

    context 'when likeable_type is Comment' do
      let(:comment) { create(:comment, article: article, user: user) }
      let(:like) do
        create_like_command.call(
          likeable_object: comment,
          user: user
        )
      end

      context 'when comment not liked by user' do
        it 'like added' do
          expect { like }.to change { comment.reload.likes_count }.by(1)
        end
      end
    end
  end
end
