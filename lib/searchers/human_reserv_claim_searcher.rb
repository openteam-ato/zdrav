module Searchers
  class HumanReservClaimSearcher < Searcher
    private

    def search
      HumanReservClaim.search do
        with :state, search_params.state if search_params.state

        paginate search_params.paginate if search_params.paginate
      end
    end

  end
end
