class OfficersController < ApplicationController
  layout 'application'
  before_filter :advertising

  def index
    show
    render('show')

  end

  def show

    @users_officers = User.sorted_by_officers.where(:status => "Active", :officers => ['President', 'Vice President', 'Secretary', 'Treasurer'])
    @users_leadership = User.sorted_by_leadership.where(:status => "Active", :leadership => ['President', 'First Vice President', 'Second Vice President', 'Third Vice President', 'Secretary'])
    @current_year=Club.last
  end
end
