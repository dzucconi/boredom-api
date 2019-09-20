# frozen_string_literal: true

module Types
  class QuestionType < Types::BaseObject
    field :id, Integer, null: false
    field :slug, String, null: false
    field :body, String, null: false

    field :related, [Types::QuestionType], null: true do
      argument :limit, Integer, required: false
      argument :sort_by, SortType, required: false
      argument :crawled, Boolean, required: false
    end

    def related(limit: 50, sort_by: 'RANDOM()', crawled: nil)
      scope = object.related
      scope = scope.where(crawled: crawled) unless crawled.nil?
      scope.order(sort_by).limit(limit)
    end
  end
end
