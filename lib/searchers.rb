module Searchers
  class Searcher
    attr_reader :search_params

    def initialize(args = {})
      @search_params = Hashie::Mash.new args
    end

    def collection
      search.results
    end

    def multiple_collection
      multiple_search.results
    end

    def total
      search.total
    end

    def multiple_total
      multiple_search.total
    end

    def with_facet(field)
      search.facet(field)
    end

    def hits
      search.hits
    end
  end
end
