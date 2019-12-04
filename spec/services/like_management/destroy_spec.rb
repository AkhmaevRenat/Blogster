# frozen_string_literal: true

require 'rails_helper'

describe LikeManagement::Destroy do
  let(:create_like_command) { LikeManagement::Create.new }
  let(:destroy_like_command) { described_class.new }

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

      let(:unlike) do
        destroy_like_command.call(
          likeable_object: article,
          user: user
        )
      end

      context 'when article was already liked by user' do
        it 'removes like' do
          like
          expect { unlike }.to change { article.reload.likes_count }.by(-1)
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

      let(:unlike) do
        destroy_like_command.call(
          likeable_object: comment,
          user: user
        )
      end

      context 'when comment was already liked by user' do
        it 'removes like' do
          like
          expect { unlike }.to change { comment.reload.likes_count }.by(-1)
        end
      end
    end
  end
end
