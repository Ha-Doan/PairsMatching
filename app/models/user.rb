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
    @students = @users.select {|user| user.role == "student"}
  end

  def get_users_array
    @user_array = []
    get_students
    @students.each do |student|
      @user_array.push(student.email)
    end
  end
  #method to pair Users
  def get_users(round)
      if round > 1
          index_right = @user_array.length/2
          right_element = @user_array[index_right]
          index_left = @user_array.length/2 -1
          left_element = @user_array[index_left]
          next_right = index_right + 1
          before_left = index_left - 1
          index_last = @user_array.length - 1
          temp_array = []
          temp_array = @user_array[next_right..index_last]
          temp_array.push(left_element)
          temp_array2 = []
          temp_array2 = @user_array[1..before_left]

          array = []
          array = array.push(@user_array[0], right_element) + temp_array2 + temp_array
          @user_array = []
          @user_array = array
    end
  end

  def find_match
    @start_date = Date.yesterday
    @result = []
    get_students
    index = @students.length - 1
    get_matches_today
    get_users_array
    if !@pairs_per_day.any?
        @user_array.shuffle
        (1..index).each do |i|

            get_users(i)
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
      if match.date.to_date == Date.today
         @pairs_per_day = match.pairs
      end
   end
   @pairs_per_day
 end
 def get_all_created_matches
   start_date = Date.today
   number_of_days = @students.length - 2
   end_date = start_date.advance(days: number_of_days)
   matches = Match.select {|match| match.date.to_date >= start_date.to_date && match.date.to_date <= end_date.to_date}
   matches
 end

  def get_matches_for_students
    start_date = Match.first.date
    @matches = Match.select {|match| match.date.to_date >= start_date.to_date && match.date.to_date <= Date.today }
  end

def get_match_from_history(date)
  @matches.each do |match|
    if match.date.to_date == date.to_date
        match.pairs.each do |pair|
          if pair[0] == self.email
            return pair[1]
          end
          if pair[1] == self.email
            return pair[0]
          end
       end
   end
end
end

def update_matches
  match_per_day = Match.new
  match_per_day.update_attribute(:date, @start_date)
  match_per_day.update_attribute(:pairs, @result)
  match_per_day
end

  private
    def set_default_role
        self.role ||=  self.update_attribute(:role,'student')
    end

end
