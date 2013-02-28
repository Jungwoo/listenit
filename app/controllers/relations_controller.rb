require 'open-uri'

class RelationsController < ApplicationController
  
  before_filter :authenticate_user!, except: [:index, :show]
  
  # GET /relations
  # GET /relations.json
  def index
    @relations = Relation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @relations }
    end
  end

  # GET /relations/1
  # GET /relations/1.json
  def show
    @relation = Relation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @relation }
    end
  end

  # GET /relations/new
  # GET /relations/new.json
  def new
    @relation = Relation.new
    @target = params[:target]
    @book_id = params[:book_id]
    
#    @book_isbn = nil
#    @related_book = nil
#    @book_already_exists = nil
#    @book_already_id = nil
    
#    if @target != nil then
#      @book_isbn = @target['isbn']
#      @related_book = Book.find(:first, :conditions=> ["isbn = ?", @book_isbn])
#    end
    
#    if @related_book != nil then
#      @book_already_exists = true
#      @book_already_id = @related_book.id
#    else
#      @book_already_exists = false
#    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @relation }
    end
  end

  # GET /relations/1/edit
  def edit
    @relation = Relation.find(params[:id])
  end

  # POST /relations
  # POST /relations.json
  def create
    @music = Music.new(params[:music])
    @relation = nil
    if @music.save 
      @relation = params[:relation]
      @relation['related_entity_id'] = @music.id
      
      @relation = Relation.new(params[:relation])

      respond_to do |format|
        if @relation.save
          format.html { redirect_to @relation, notice: 'Relation is successfully created.' }
          format.json { render json: @relation, status: :created, location: @relation }
        else
          format.html { render action: "new" }
          format.json { render json: @relation.errors, status: :unprocessable_entity }
        end
      end
    else
      format.html { render action: "new" }
      format.json { render json: @book.errors, status: :unprocessable_entity }
    end
  end

  # PUT /relations/1
  # PUT /relations/1.json
  def update
    @relation = Relation.find(params[:id])

    respond_to do |format|
      if @relation.update_attributes(params[:relation])
        format.html { redirect_to @relation, notice: 'Relation is successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relations/1
  # DELETE /relations/1.json
  def destroy
    @relation = Relation.find(params[:id])
    @relation.destroy

    respond_to do |format|
      format.html { redirect_to relations_url }
      format.json { head :no_content }
    end
  end
  
  # Search the music by keyword from Youtube
  def search
    @keyword = params[:keyword]
    @class = params[:class]
    @book_id = params[:book_id]
    @start_index = params[:start_index]
    if @start_index.to_s.length == 0 then
      @start_index = 1
    end
    #if keyword.to_s.length == 0 then
    #  redirect_to new_book_path, :notice => "Please input keyword"
    #end
    result = JSON.parse(open(URI.encode("https://gdata.youtube.com/feeds/api/videos?category=Music&q=#{@keyword}&key=AI39si5g25khnVDxoMQfiuVr3Og2p7XffY3UMgnxXpn9AHfC4Nsk4evMcKS6u7CN7PQXg4x0mZZr_Wk08oono9Pqv7gfeNts_w&alt=json&v=2&start-index=#{@start_index}&max-results=10")).read)
    @search_result = result
  end
end
