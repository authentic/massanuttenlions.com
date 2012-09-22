class NewslettersController < ApplicationController
  #require 'rubygems'
  #require 'data_mapper'
  require 'google/api_client'
  require 'logger'
  CALLBACK_URL = "http://localhost:3000/oauth/callback"
  before_filter :authenticate_user!, :except => [:index]
  before_filter :admin_user, :except => [:index]
  before_filter :advertising
  layout :layout_by_resource


  def index

    @newsletter= Newsletter.order('newsletters.period ASC').where(:visible => true).last
    @club=Club.first

  end


  def list
    @newsletters = Newsletter.order('newsletters.period DESC')
  end

  def show
    @newsletter = Newsletter.find(params[:id])

  end

  def new
    @newsletter=Newsletter.new
  end

  def create
    #Instantiate a new object using form parameters
    @newsletter=Newsletter.new(params[:newsletter])
    #Save the object
    if @newsletter.save
      #If save succeeds, redirect to the list action
      flash[:notice] = "Newsletter created."
      redirect_to(:action => 'fill', :id => @newsletter.id)
    else
      #if save fails, redisplay the form so us
      render('new')
    end

  end


  def edit
    @newsletter=Newsletter.find(params[:id])

  end

  def fill
    @newsletter=Newsletter.find(params[:id])
    @club=Club.first
    @president = User.where(:status => "Active", :leadership => %w(President)).first
    @editor=User.where(:status => "Active", :newsletter_editor => %w(Editor)).first
    @secretary=User.where(:status => "Active", :leadership => %w(Secretary)).first
    @leaders = User.sorted_by_leadership.where(:status => "Active", :leadership => ['President', 'First Vice President', 'Second Vice President', 'Third Vice President', 'Secretary', 'Treasure', 'Lion Tamer', 'Tail Twister', 'Membership Chair', 'Director 001 Year', 'Director 2 Year', 'Past President'])
    @users=User.where(:status => "Active")
  end

  def update
    #Find object using form parameters
    @newsletter=Newsletter.find(params[:id])
    #Update the object
    if @newsletter.update_attributes(params[:newsletter])
      #If update succeeds, redirect to the list action
      flash[:notice] = "Newsletter updated."
      redirect_to(:action => 'show', :id => @newsletter.id
      )
    else
      #if update fails, redisplay the form so us
      render('edit')
    end


  end

  def delete
    @newsletter=Newsletter.find(params[:id])
  end

  def destroy #Process delete record form
    newsletter = Newsletter.find(params[:id])
    newsletter.destroy
    flash[:notice] = "Newsletter destroyed."
    redirect_to(:action => 'list')
  end


  protected
  def layout_by_resource
    if controller_name == 'newsletters' && action_name == 'index'
      'application'
    else
      'admin'
    end
  end
end