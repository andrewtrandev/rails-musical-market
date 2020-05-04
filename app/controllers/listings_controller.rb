class ListingsController < ApplicationController
    before_action :authenticate_user!
    #check to see if user is logged in before allowing them access to listings methods
    def index
        @listings=Listing.all
    end
end