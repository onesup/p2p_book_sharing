# coding : utf-8

class DealsController < ApplicationController

  # GET /deals
  # GET /deals.json
  def index
    @user = User.find(params[:user_id])
    @buying_deals = @user.buying_deals
    @selling_deals = @user.selling_deals
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @deals }
    end
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
    @deal = Deal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @deal }
    end
  end

  # GET /deals/new
  # GET /deals/new.json
  def new
    @deal = Deal.new
    if Collection.exists?(params[:collection_id])
      @collection = Collection.find(params[:collection_id])
      @seller = @collection.user
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @deal }
    end
  end

  # GET /deals/1/edit
  def edit
    @deal = Deal.find(params[:id])
    @user = User.find(params[:user_id])
    @collection = @deal.collection
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(params[:deal])

    respond_to do |format|
      if @deal.save
        if logged_in?
          format.html { redirect_to user_deals_path(current_user.id), notice: 'Deal was successfully created.' }
          format.json { render json: @deal, status: :created, location: @deal }
        else
          format.html { redirect_to @deal, notice: 'Deal was successfully created.' }
          format.json { render json: @deal, status: :created, location: @deal }
        end
      else
        format.html { render action: "new" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /deals/1
  # PUT /deals/1.json
  def update
    @deal = Deal.find(params[:id])

    respond_to do |format|
      if @deal.update_attributes(params[:deal])
        format.html { redirect_to user_deals_path(@deal.seller), notice: 'Deal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy

    respond_to do |format|
      format.html { redirect_to deals_url }
      format.json { head :no_content }
    end
  end

private  

  # def get_collection
  #   if params[:collection_id] && Collection.exists?(params[:collection_id])
  #     @collection = Collection.find(params[:collection_id])
  #   end
  #   @collection
  # end
end
