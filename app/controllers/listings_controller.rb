class ListingsController < ApplicationController
    def new         
        @listing = Listing.new
    end

    def create
        list = Listing.new(listing_params)
        list.user_id = c_user_id
        list.save
        new_id = User.find(c_user_id).listings[-1].id
        redirect_to listing_path(new_id)
    end

    def index
        @listings = Listing.all
        min_price = Listing.all.minimum("price")
        max_price = Listing.all.maximum("price")
        
        if params[:min_price] || params[:max_price]
            min_price = params[:min_price].to_i
            max_price = params[:max_price].to_i
            @listings = @listings.where(price: (min_price..max_price))
        end
        
        if params[:title]
            @listings = @listings.where('lower(title) LIKE ?', "%#{params[:title].downcase}%") #more secure? % % is wildcard in sql
        end
        
        @listings = @listings.order(:price).page (params[:page])
        
        respond_to do |format|
            format.html    
            format.js
        end
    end

    def results

    end

    def show
        @listing = Listing.find(params[:id])
    end

    def edit
        @listing = Listing.find(params[:id])
    end

    def update
        list = Listing.find(params[:id])
        list.update(listing_params)
        redirect_to listing_path(list.id)
    end

    def destroy
        @listing = Listing.find(params[:id]).delete
        redirect_to root_path
    end

    def verify
        if current_user.role != "member"
            Listing.find(params[:id]).update(verify: true)
        end
        redirect_back(fallback_location: root_path)
    end

    private
    def listing_params
        params.require(:listing).permit(
            :title, 
            :description, 
            :address, 
            :district, 
            :state, 
            :country, 
            :room, 
            :bath, 
            :adult, 
            :children, 
            :price,
            {images: []}
        )
      end 
end
