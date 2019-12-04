# frozen_string_literal: true

class RetweetManagement::Destroy
  Result = Struct.new(:success?, :context)

  def call(article)
    destroy_retweet(article)
  end

  private

  def destroy_retweet(article)
    if article.present?
      article.destroy!
      Result.new(true, 'Retweet successfully removed')
    else
      Result.new(false, 'Error: retweet does not exists or already removed')
    end
  end
end
