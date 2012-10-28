class ListPagesController < ApplicationController
  # GET /list_pages
  # GET /list_pages.json
  def index
    @list_pages = ListPage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @list_pages }
      format.csv { render csv: @list_pages }
    end
  end

  # GET /list_pages/1
  # GET /list_pages/1.json
  def show
    @list_page = ListPage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @list_page }
    end
  end

  # GET /list_pages/new
  # GET /list_pages/new.json
  def new
    @list_page = ListPage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @list_page }
    end
  end

  # GET /list_pages/1/edit
  def edit
    @list_page = ListPage.find(params[:id])
  end

  # POST /list_pages
  # POST /list_pages.json
  def create
    @list_page = ListPage.new(params[:list_page])

    respond_to do |format|
      if @list_page.save
        format.html { redirect_to @list_page, notice: 'List page was successfully created.' }
        format.json { render json: @list_page, status: :created, location: @list_page }
      else
        format.html { render action: "new" }
        format.json { render json: @list_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /list_pages/1
  # PUT /list_pages/1.json
  def update
    @list_page = ListPage.find(params[:id])

    respond_to do |format|
      if @list_page.update_attributes(params[:list_page])
        format.html { redirect_to @list_page, notice: 'List page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @list_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /list_pages/1
  # DELETE /list_pages/1.json
  def destroy
    @list_page = ListPage.find(params[:id])
    @list_page.destroy

    respond_to do |format|
      format.html { redirect_to list_pages_url }
      format.json { head :no_content }
    end
  end
end
