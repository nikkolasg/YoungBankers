class ArticlesController < ApplicationController
    before_action: :signed_in_user , only: [ :create, :destroy ]

    def create
        @article = current_user.articles.build(article_params)
        if @article.save
            flash[:success] = "Article saved !"
            redirect_back current_user
        else 
            flash[:error] = "Error while saving ... "
        end
    end

    def destroy

    end
    private

    def article_params
        params.require(:article).permit(:title,:content)
    end
end
