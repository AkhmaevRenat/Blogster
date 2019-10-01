# frozen_string_literal: true

module UsersHelper
  def display_query_sql(users)
    tag.p('SQL:') + tag.code(users.to_sql)
  end
end
