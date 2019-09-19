# frozen_string_literal: true

module Types
  class SortType < BaseEnum
    value 'CREATED_AT_ASC', value: { created_at: :asc }
    value 'CREATED_AT_DESC', value: { created_at: :desc }
    value 'UPDATED_AT_ASC', value: { updated_at: :asc }
    value 'UPDATED_AT_DESC', value: { updated_at: :desc }
    value 'RANDOM', value: 'RANDOM()'
  end
end
