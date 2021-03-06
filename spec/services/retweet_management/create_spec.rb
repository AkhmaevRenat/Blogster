# frozen_string_literal: true

require 'rails_helper'

describe RetweetManagement::Create do
  let(:create_command) { described_class.new }

  describe '#call' do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    context 'when Article is not retweeted' do
      it 'makes retweet' do
        created_article = create_command.call(
          article: article,
          user: user
        ).retweet
        aggregate_failures do
          expect(created_article.title).to eq(article.title)
          expect(created_article.text).to eq(article.text)
          expect(created_article.retweeted_id).to eq(article.id)
        end
        expect(created_article).to be_valid
      end
    end
  end
end
