class StaticPagesController < ApplicationController
  def home
    #If the user is signed in, redirect to the dashboard
    if current_user
      redirect_to dashboard_path
    end
  	@title = "Home"
  end

  def dashboard
    if !current_user
      redirect_to root_path
    end
    @title = "Dashboard"
  end
  
  def learn
    @title = "Learn"
  end

  def learnleagues
    @title = "Learn Leagues"
  end

  def settings
    if !current_user
      redirect_to root_path
    end
    @title = "My settings"
  end

  def about
    @title = "About"
  end

  def help
    if !current_user
      redirect_to root_path
    end
    @title = "Help and FAQ"
  end

  def contact
    @title = "Contact Us"
  end

  def permission_denied
    @title = "Permission denied"
  end

end
