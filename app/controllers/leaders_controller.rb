class LeadersController < ApplicationController
  layout 'application'
  before_filter :advertising

  def index
    show
    render('show')

  end

  def show
    @users = User.sorted_by_leadership.where(:status => "Active", :leadership => ['President', 'First Vice President', 'Second Vice President', 'Third Vice President', 'Secretary', 'Treasure', 'Lion Tamer', 'Tail Twister', 'Membership Chair', 'Director 1 Year', 'Director 2 Year', 'Past President'])
    @current_year=Club.last
  end
end
