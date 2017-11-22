class Match < ApplicationRecord



  def match_by_date(date)
   your_match_for_date = Match.where(date: date)
   @your_match_was = your_match_for_date.find_match
  end



end
