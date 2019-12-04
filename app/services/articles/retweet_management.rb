# frozen_string_literal: true

class Articles::RetweetManagement
  Result = Struct.new(:retweet) do
  end

  def call(article:, user:)
    retweet = article.retweet_of(article, user)
    if retweet.present?
      retweet.destroy!
    else
      retweet = Article.new(title: article.title, text: article.text, retweeted_id: article.id, user: user)
      retweet.save!
    end
    retweet
  end
end
