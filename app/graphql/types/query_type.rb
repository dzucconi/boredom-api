# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :total, Integer, null: false

    def total
      Question.count
    end

    field :questions, [QuestionType], null: false do
      argument :limit, Integer, required: false
      argument :sort_by, SortType, required: false
      argument :crawled, Boolean, required: false
    end

    def questions(limit: 50, sort_by: 'RANDOM()', crawled: nil)
      scope = Question.all
      scope = scope.where(crawled: crawled) unless crawled.nil?
      scope.order(sort_by).limit(limit)
    end
  end
end
