class ContactsController < ApplicationController
  layout 'contact'
  before_filter :advertising

  def contact_us
    @club=Club.all
  end

  def president
    @club=Club.all
    @president= User.where(:status => "Active", :leadership => ['President']).first

  end

  def webmaster
    @club=Club.all
    @webmaster= User.sorted.where(:status => "Active", :webmaster => ['Webmaster'])

  end

  def feedback
  end
end
