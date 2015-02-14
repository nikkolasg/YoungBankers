class PortfolioController < ApplicationController

    def animals
        render 'animal_welfare_portfolio'
    end
    
    def environment
        render 'ecology_portfolio'
    end

    def health_hygiene
        render 'hygiene_health_portfolio'
    end

    def education
        render 'education_portfolio'
    end

    def poverty
        render 'poverty_portfolio'
    end

    def infrastructure
        render 'infrastructure_portfolio'
    end

    ## Sub items
    def education_rota
        render 'education_rota'
    end
    def education_bf
        render 'education_bf'
    end

    def health_hi
        render 'health_hi'
    end
    def health_msf
        render 'health_msf'
    end

    def infra_hfh
        render 'infrastructure_hfh'
    end

    def poverty_acumen
        render 'poverty_acumen'
    end
    def poverty_brac
        render 'poverty_brac'
    end
    def poverty_irc
        render 'poverty_international_rescue'
    end
    def poverty_mercy_corps
        render 'poverty_mercy_corps'
    end
end
