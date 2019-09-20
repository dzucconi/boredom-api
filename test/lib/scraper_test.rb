# frozen_string_literal: true

require 'byebug'
require 'test_helper'

require_relative '../../lib/scraper'

Link = Struct.new(:href, :text)

class ScraperTest < ActiveSupport::TestCase
  test "returns false on answer URLs" do
    link = Link.new('/What-does-your-countrys-currency-look-like/answer/Kim-Teo-6', '...?')
    assert(!Scraper::IS_QUESTION.call(link))
  end

  test "but not questions that have the word answer in them" do
    link = Link.new('/What-does-your-countrys-currency-look-like-answer', '...?')
    assert(Scraper::IS_QUESTION.call(link))
  end
end
