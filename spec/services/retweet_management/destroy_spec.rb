# frozen_string_literal: true

require 'rails_helper'

describe RetweetManagement::Destroy do
  let(:create_retweet_command) { RetweetManagement::Create.new }
  let(:destroy_retweet_command) { described_class.new }

  describe '#call' do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    context 'when Article is already retweeted' do
      it 'deletes retweet' do
        retweet = create_retweet_command.call(
          article: article,
          user: user
        ).retweet
        expect do
          destroy_retweet_command.call(retweet)
        end .to change(Article.where(retweeted_id: article.id), :count).by(-1)
      end
    end
  end
end
