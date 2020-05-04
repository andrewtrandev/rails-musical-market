class ListingsController < ApplicationController
    before_action :authenticate_user!
    #check to see if user is logged in before allowing them access to listings methods
    def index
        @listings=Listing.all
        
        generate_stripe_session
       
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

    def show
        @listing=Listing.find(params["id"])
    end

    def edit
        @listing =current_user.listings.find_by_id(params["id"])
        #if you use  @listing =current_user.listings.find(params["id"]) it errors
        #only allow the current user to find listings they've created by id
        #edit is handling the get request to render html
        if @listing
            render "edit"
        else
            redirect_to listings_path
        end

    end


    def update
        @listing = current_user.listings.find_by_id(params["id"])

        if @listing
            #if @listing exsits
            @listing.update(listing_params)
            if @listing.errors.any?
                #if any errors in updating re-render the edit view
                render "edit"
            else
                #otherwise redirect to index
                redirect_to listings_path
            end
        else
            #otherwise refdirect to index if no listing existss
            redirect_to listings_path
        end
    end


    def destroy
        #we want only users who create listings to be able to delete thos e listings
        @listing =current_user.listings.find_by_id(params["id"])

        if @listing
            @listing.destroy
        end
        
        redirect_to listings_path
    end






    private
    def listing_params
        params.require(:listing).permit(:title, :description, :price)
    end

    def get_users_listing
        @listing = current_user.listings.find_by_id(params["id"])
        #make a before_action for edit, update destroy
    end


    def generate_stripe_session
         #below code is used to create a session
         session = Stripe::Checkout::Session.create(
            payment_method_types: ['card'],
            customer_email: current_user.email,
            line_items: [{
            name: "Donate to Musician Marketplace!",
            currency: 'aud',
            quantity: 1,
            amount: 1000
            }],
            payment_intent_data: {
            metadata: {
            user_id: current_user.id,
            }
            },
            success_url: "#{root_url}pages/donated?userId=#{current_user.id}",
            
            cancel_url: "#{root_url}"
            )
    
            @session_id = session.id
        end


end