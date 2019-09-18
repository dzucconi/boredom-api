# frozen_string_literal: true

require 'mechanize'

class Agent
  attr_reader :agent

  def initialize
    @agent = Mechanize.new.tap do |a|
      a.user_agent_alias = 'Mac Safari'
    end
  end

  def get(url)
    snooze_for = rand(0.5..2.5)
    puts "zzzzz... #{snooze_for}"
    sleep snooze_for
    puts "Fetching: <#{url}>"
    agent.get(url)
  end
end
