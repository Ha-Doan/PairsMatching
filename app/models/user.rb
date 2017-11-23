require 'date'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #before_create :set_default_role
  validates :role,    presence: true

  def get_students
    @users = User.all
    @students = @users.select {|user| user.role = "student"}

  end
  def get_users_array
    @user_array = []
    get_students
    @students.each do |student|
      @user_array.push(student.email)
    end

  end
  #method to pair Users
  def get_users(seed_for_randomness)

      if seed_for_randomness > 1
          index_right = @user_array.length/2
          right_element = @user_array[index_right]
          index_left = @user_array.length/2 -1
          left_element = @user_array[index_left]
          index_second_last = @user_array.length - 2
          index_last = index_second_last + 1
          temp_array = []
          temp_array = @user_array[index_second_last..index_last]
          temp_array.push(left_element)
          array = []
          array.push(@user_array[0], right_element,@user_array[1])
          @user_array = []
          @user_array = array + temp_array
    end
  end

  def find_match
    @start_date = 6.days.ago.to_date
    @result = []
    get_students
    index = @students.length - 1
    get_matches_today
    get_users_array
    if !@pairs_per_day.any?
        (1..index).each do |i|

            get_users(i)
            byebug
            cut_index = @user_array.length/2 - 1
            @result = []
            (0..cut_index).each do |i|
                index_of_match = @user_array.length/2 + i
                match = []
                match.push(@user_array[i], @user_array[index_of_match])
                @result.push(match)
            end
            @start_date = @start_date.tomorrow
            update_matches

        end
    else
      @result = []
      @result = @pairs_per_day
    end
    @result
 end


 def get_matches_today
   @pairs_per_day = []
   Match.all.each do |match|
      if match.date == 5.days.ago.to_date
         @pairs_per_day = match.pairs
      end
   end
   @pairs_per_day
 end
 def get_all_created_matches
   start_date = 5.days.ago.to_date
   end_date = Date.today
   matches = Match.select {|match| match.date.to_date >= start_date.to_date && match.date.to_date <= end_date.to_date}
   matches
 end

  def get_match
    @result.each do |pair|
      if pair[0] == self.email
          return pair[1]
      end

      if pair[1] == self.email
          return pair[0]
      end
    end
  end
  def get_match_for_date(date)
    Match.all.each do |match|
       if match.date == date
          @result1 = match.pairs
       end
    end
    @result1.each do |pair|
      if pair[0] == self.email
          return pair[1]
      end

      if pair[1] == self.email
          return pair[0]
      end
    end
  end

  def all_match
    Match.all
  end
 def get_user_array
   @user_array
end
def is_user_paired_today?
   @pairs_per_day.each do |pair|
      if pair.include?(self.email)
        return true
      end
   end
   return false
end
def update_matches
  match_per_day = Match.new
  match_per_day.update_attribute(:date, @start_date)
  match_per_day.update_attribute(:pairs, @result)
  match_per_day
  byebug
end

  private
    def set_default_role
        self.role ||=  self.update_attribute(:role,'student')
    end

end
