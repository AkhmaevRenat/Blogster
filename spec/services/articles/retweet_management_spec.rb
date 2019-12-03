# frozen_string_literal: true

require 'rails_helper'

describe Articles::RetweetManagement do
  let(:retweet_management_command) { described_class.new }

  describe '#call' do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    context 'when Article is not retweeted' do
      it 'makes retweet' do
        created_article = retweet_management_command.call(
          article: article,
          user: user
        )
        aggregate_failures do
          expect(created_article.title).to eq(article.title)
          expect(created_article.text).to eq(article.text)
          expect(created_article.retweeted_id).to eq(article.id)
        end
        expect(created_article).to be_valid
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
