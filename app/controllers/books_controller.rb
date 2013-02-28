require 'open-uri'

class BooksController < ApplicationController
  
  before_filter :authenticate_user!, except: [:index, :show]
  
  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
    @relations = Relation.find(:all, :conditions => ["book_id = ?", params[:id]])
    @relation_count = @relations.count
    @related_entities = Array.new
    
    # Must optimize the code below !!!
    @relations.each do | relation |
      @related_entities.push(Music.find(:last, :conditions => ["id = ?", relation.related_entity_id]))
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new
    @target = params[:target]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])
    @relation = Hash.new
    
    respond_to do |format|
      if @book.save          
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end
  
  # Search the book by keyword from Daum Books
  def search
    @keyword = params[:keyword]
    @class = params[:class]
    @book_id = params[:book_id]
    @page_no = params[:page_no]
    if @page_no.to_s.length == 0 then
      @page_no = 1
    else
      @page_no = Integer(@page_no)
    end
    @itemsPerPage = 10
    #if keyword.to_s.length == 0 then
    #  redirect_to new_book_path, :notice => "Please input keyword"
    #end
    result = JSON.parse(open(URI.encode("http://apis.daum.net/search/book?q=#{@keyword}&sort=accu&output=json&searchType=title&apikey=a720f3b1c148fd3a6bd1c81d0787e84c4e9e8d5b&pageno=#{@page_no}&result=#{@itemsPerPage}&sort=accu")).read)
    @search_result = result
  end

end
