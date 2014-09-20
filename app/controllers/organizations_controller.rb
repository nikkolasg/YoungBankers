class OrganizationsController < ApplicationController
    def list
        render json: Organization.all.map(&:name)
    end
    def auto_complete
        render json: Organization.search(params[:query], fields: [ {name: :text_start} ], limit: 10).map(&:name) 
    end
end
