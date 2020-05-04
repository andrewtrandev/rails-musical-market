class ListingsController < ApplicationController
    before_action :authenticate_user!
    #check to see if user is logged in before allowing them access to listings methods
    def index
        @listings=Listing.all
        
    end

    def new 
        @listing=Listing.new
    end
    
    def create
        @listing=current_user.listings.create(listing_params)
        #create a listing on the current user using the permmited params
        if @listing.errors.any?
            render "new"
        else
            redirect_to listings_path
            #redirect to index
        end

   
    end


    private
    def listing_params
        params.require(:listing).permit(:title, :description, :price)
    end

end