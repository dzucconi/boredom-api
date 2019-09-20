# frozen_string_literal: true

require_relative './agent'
require_relative './topics'

ROOT_URL = 'https://en.quora.com'

IS_QUESTION = lambda { |link|
  return false if link.href.nil?

  parsed = Scraper.parse(link.href)

  (parsed.host.blank? || (parsed.host == 'www.quora.com' || parsed.host == 'en.quora.com')) &&
    link.text =~ /\?$/ &&
    link.text !~ /quora/i &&
    link.text !~ %r{/math} &&
    link.href !~ %r{/wiki|unanswered|topic|undefined|coding|conctact|about|careers|profile|answer/}
}

module Scraper
  IS_QUESTION = IS_QUESTION

  class << self
    def parse(url)
      Addressable::URI.parse(url)
    end

    def process_question(url, agent = Agent.new)
      page = agent.get(url)

      related_questions = page.links.select(&IS_QUESTION).uniq(&:text)

      {
        body: page.title.gsub(' - Quora', ''),
        slug: page.uri.path.slice(1..),
        url: url,
        related: related_questions.map do |link|
          {
            body: link.text,
            slug: parse(link.href).path.slice(1..),
            url: "#{ROOT_URL}#{parse(link.href).path}"
          }
        end
      }
    rescue StandardError
      puts "Failed <#{url}>"
      nil
    end

    def process_topic(url, agent = Agent.new)
      page = agent.get(url)
      questions = page.links.select(&IS_QUESTION).uniq(&:text)

      questions.map do |link|
        {
          body: link.text,
          slug: parse(link.href).path.slice(1..),
          url: "#{ROOT_URL}#{parse(link.href).path}"
        }
      end
    rescue StandardError
      puts "Failed <#{url}>"
      []
    end

    def seed(topics = TOPICS, agent = Agent.new)
      topics.each do |slug|
        next if (seed_questions = process_topic("#{ROOT_URL}/topic/#{slug}", agent)).size.zero?

        seed_questions.each do |seed_question|
          root = process_question(seed_question[:url], agent)

          next if root.nil?

          question = Question.find_or_initialize_by(
            body: root[:body],
            slug: root[:slug],
            url: root[:url],
            crawled: true
          )

          related_questions = root[:related].map { |related| Question.find_or_create_by!(related) }
          question.related_question_ids = related_questions.pluck(:id)
          question.save!
        end
      end
    end
  end
end
