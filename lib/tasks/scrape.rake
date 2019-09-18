# frozen_string_literal: true

require_relative '../scraper'

namespace :scrape do
  task seed: :environment do
    Scraper.seed
  end

  task run: :environment do
    Question.where(crawled: false).order('RANDOM()').limit(20).each(&:crawl)
  end
end
