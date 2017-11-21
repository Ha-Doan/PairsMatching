class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :set_default_role
  validates :role,    presence: true

  def users
    @users = User.all
  end

  #method to pair Users
  def pairs
    user_array = []
    @pairs_a_day = []
    users = User.all
    users.each do |user|
      user_array.push(user.email)
    end
    @combinations = user_array.combination(2)
    @match_today = Match.first #where(date: Date.today})
    @pairs_a_day = @match_today.pairs
  end

  def find_match
    already_matched = []
    result = []

    possible_pairs = pairs
    possible_pairs.each do |pair|
      if !already_matched.any?
       already_matched = pair
       result.push(pair)
     else
       if !(pair.include?(already_matched[0]) || pair.include?(already_matched[1]))
        result.push(pair)
        already_matched = []
        already_matched = pair
       end
      end
    end

  @match = result
    result.each do |pair|
      if pair[0] == self.email
          make_pair_a_day(pair[0], pair[1])
          return pair[1]
      end

      if pair[1] == self.email
           make_pair_a_day(pair[1], pair[0])
           return pair[0]
      end
    end

  end

  def matched_pairs
    @match
  end

def make_pair_a_day(user1, user2)
  ordered_pair1 = []
  ordered_pair2 = []
  ordered_pair1.push(user1)
  ordered_pair1.push(user2)
  ordered_pair2.push(user2)
  ordered_pair2.push(user1)
  if !@pairs_a_day.any?
      @pairs_a_day.push(ordered_pair1)
  else
      if !(@pairs_a_day.include?(ordered_pair1) || @pairs_a_day.include?(ordered_pair2))
          @pairs_a_day.push(ordered_pair1)
      end
  end
  @match_a_day = Match.new
  date = @match_a_day.created_at
  @match_a_day.update_attribute(:date, date)
  @match_a_day.update_attribute(:pairs, @pairs_a_day)
  @match_a_day
end

def my_match_a_day
   @match_a_day.pairs.each do |pair|
     if pair.include?(self.email)
       return pair
     end
  end
end
  private
    def set_default_role
        self.role ||=  self.update_attribute(:role,'student')
    end

end
