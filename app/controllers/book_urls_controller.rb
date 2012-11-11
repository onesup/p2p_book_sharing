class BookUrlsController < ApplicationController
  # GET /book_urls
  # GET /book_urls.json
  def index
    @book_urls = BookUrl.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @book_urls }
    end
  end

  # GET /book_urls/1
  # GET /book_urls/1.json
  def show
    @book_url = BookUrl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book_url }
    end
  end

  # GET /book_urls/new
  # GET /book_urls/new.json
  def new
    @book_url = BookUrl.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book_url }
    end
  end

  # GET /book_urls/1/edit
  def edit
    @book_url = BookUrl.find(params[:id])
  end

  # POST /book_urls
  # POST /book_urls.json
  def create
    @book_url = BookUrl.new(params[:book_url])

    respond_to do |format|
      if @book_url.save
        format.html { redirect_to @book_url, notice: 'Book url was successfully created.' }
        format.json { render json: @book_url, status: :created, location: @book_url }
      else
        format.html { render action: "new" }
        format.json { render json: @book_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /book_urls/1
  # PUT /book_urls/1.json
  def update
    @book_url = BookUrl.find(params[:id])

    respond_to do |format|
      if @book_url.update_attributes(params[:book_url])
        format.html { redirect_to @book_url, notice: 'Book url was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /book_urls/1
  # DELETE /book_urls/1.json
  def destroy
    @book_url = BookUrl.find(params[:id])
    @book_url.destroy

    respond_to do |format|
      format.html { redirect_to book_urls_url }
      format.json { head :no_content }
    end
  end
end
