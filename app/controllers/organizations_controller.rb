class OrganizationsController < ApplicationController
    def auto_complete

        render json: Organization.search (params[:query], fields: [ {name: :text_start} ], limit: 10) 
    end
end
