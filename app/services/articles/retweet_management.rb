# frozen_string_literal: true

class Articles::RetweetManagement
  Result = Struct.new(:success?, :context)

  def call(article:, user:)
    retweet = article.retweet_of(article, user)
    if retweet.present?
      destroy_retweet(retweet)
    else
      create_retweet(article, user)
    end
  end

  private

  def destroy_retweet(retweet)
    Article.transaction do
      retweet.destroy!
    end
  end

  def create_retweet(article, user)
    retweet = Article.new(title: article.title, text: article.text, retweeted_id: article.id, user: user)
    retweet.save!
  end
end
