module Pagination
  extend ActiveSupport::Concern

  RECORDS_PER_PAGE = 15

  included do
    paginates_per(RECORDS_PER_PAGE)
  end
end
