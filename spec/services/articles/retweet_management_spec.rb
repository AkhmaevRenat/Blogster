# frozen_string_literal: true

require 'rails_helper'

describe Articles::RetweetManagement do
  let(:retweet_management_command) { described_class.new }

  describe '#call' do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    context 'when Article is not retweeted' do
      it 'makes retweet' do
        retweet_management_command.call(
          article: article,
          user: user
        )
        expect(Article.find_by(retweeted_id: article.id, user: user)).to be_valid
      end
    end

    context 'when Article is already retweeted' do
      it 'deletes retweet' do
        retweet_management_command.call(
          article: article,
          user: user
        )
        expect do
          retweet_management_command.call(
            article: article,
            user: user
          )
        end .to change(Article.where(retweeted_id: article.id), :count).by(-1)
      end
    end
  end
end
