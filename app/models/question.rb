# frozen_string_literal: true

require_relative '../../lib/scraper'

class Question < ApplicationRecord
  def related
    @related ||= Question.find(related_question_ids)
  end

  def crawl
    return if crawled?

    response = Scraper.process_question(url)
    related_questions = response[:related].map { |related| self.class.find_or_create_by!(related) }
    self.related_question_ids = related_questions.pluck(:id)
    self.crawled = true
    save!
  end
end
