class OfficersController < ApplicationController
  layout 'application'
  before_filter :advertising

  def index
    show
    render('show')

  end

  def show
    @users = User.sorted_by_officers.where(:status => "Active", :officers => ['President', 'Vice President', 'Secretary', 'Treasurer', 'Director'])
    @current_year=Club.last
  end
end
