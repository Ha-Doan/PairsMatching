class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :set_default_role
  validates :role,    presence: true


  #method to pair Users
  def pairs
    user_array = []
    users = User.all
    users.each do |user|
      user_array.push(user.email)
    end
    @combinations = user_array.combination(2)
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
          return pair[1]
        end
        if pair[1] == self.email
          return pair[0]
        end
      end
  end

  def matched_pairs
    @match
  end


  private
    def set_default_role
        self.role ||=  self.update_attribute(:role,'student')
    end

end
