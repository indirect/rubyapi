# frozen_string_literal: true

class SearchQuery
  QUERY_OPTION_PATTERN = /\w+\:\w+/.freeze

  attr_reader :query

  def initialize(query = "")
    @query = query.to_s.freeze
    @options = Set.new
    @terms = Set.new

    parse_search_query
  end

  def terms
    @terms.uniq
  end

  def filters
    filters = {}
    @options.each do |f|
      key, value = f.split(":")
      filters[key.to_sym] = value
    end

    filters
  end

  private

  def parse_search_query
    @query.strip.split(" ").each do |token|
      if token =~ QUERY_OPTION_PATTERN
        @options << token
      else
        @terms << token
      end
    end
  end
end