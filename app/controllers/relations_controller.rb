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
    
    @book_isbn = nil
    @related_book = nil
    @book_already_exists = nil
    @book_already_id = nil
    
    if @target != nil then
      @book_isbn = @target['isbn']
      @related_book = Book.find(:first, :conditions=> ["isbn = ?", @book_isbn])
    end
    
    if @related_book != nil then
      @book_already_exists = true
      @book_already_id = @related_book.id
    else
      @book_already_exists = false
    end
    
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
    @book = Book.new(params[:book])
    @relation = nil
    if @book.save 
      @relation = params[:relation]
      @relation['related_entity_id'] = @book.id
      
      @relation = Relation.new(params[:relation])

      respond_to do |format|
        if @relation.save
          format.html { redirect_to @relation, notice: 'Relation was successfully created.' }
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
        format.html { redirect_to @relation, notice: 'Relation was successfully updated.' }
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
  
end