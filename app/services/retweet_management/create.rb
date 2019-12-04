# frozen_string_literal: true

class RetweetManagement::Create
  Result = Struct.new(:success?, :context, :retweet)

  def call(article:, user:)
    create_retweet(article, user)
  end

  private

  def create_retweet(article, user)
    if User.retweeters(article.id).find_by(id: user.id).present?
      Result.new(false, 'Erorr: retweet is alreay exists')
    else
      retweet = Article.new(title: article.title,
                            text: article.text,
                            retweeted_id: article.id,
                            user: user)
      retweet.save!
      Result.new(true, 'Article successfully retweeted', retweet)
    end
  end
end
