class MoodsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /moods
  # GET /moods.json
  def index
    @moods = current_user.moods.order("date DESC")

    respond_to do |format|
      format.html do
        @moods_grouped_by_date = current_user.moods.order("date DESC")
      end
      format.json { render json: @moods }
    end
  end

  # GET /moods/1
  # GET /moods/1.json
  def show
    @mood = Mood.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mood }
    end
  end

  # GET /meals/new
  # GET /meals/new.json
  def new
    @mood = Mood.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mood }
    end
  end

  # GET /meals/1/edit
  def edit
    @mood = Mood.find(params[:id])
  end

  # POST /meals
  # POST /meals.json
  def create
    @mood = current_user.moods.new(params[:mood])

    respond_to do |format|
      if @mood.save
        format.html { redirect_to moods_path, notice: 'Mood was successfully created.' }
        format.json { render json: @mood, status: :created, location: @mood }
      else
        format.html { render action: "new" }
        format.json { render json: @mood.errors, status: :unprocessable_entity }
      end
    end
  end

end