class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    render({ :template => "users/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_users = User.where({ :username => the_id })

    @the_user = matching_users.at(0)

    render({ :template => "users/show.html.erb" })
  end

  def show_photos
    the_id = params.fetch("path_id")

    matching_users = User.where({ :username => the_id })

    @the_user = matching_users.at(0)

    render({ :template => "users/show_photos.html.erb" })
  end

  def show_discover
    the_id = params.fetch("path_id")

    matching_users = User.where({ :username => the_id })

    @the_user = matching_users.at(0)

    render({ :template => "users/show_discover.html.erb" })
  end

  def show_feed
    the_id = params.fetch("path_id")

    matching_users = User.where({ :username => the_id })

    @the_user = matching_users.at(0)

    render({ :template => "users/show_feed.html.erb" })
  end

  def create
    the_user = User.new
    the_user.comments_count = params.fetch("query_comments_count")
    the_user.email = params.fetch("query_email")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.password_digest = params.fetch("query_password_digest")
    the_user.private = params.fetch("query_private", false)
    the_user.username = params.fetch("query_username")


    if the_user.valid?
      the_user.save
      redirect_to("/users", { :notice => "User created successfully." })
    else
      redirect_to("/users", { :notice => "User failed to create successfully." })
    end

    #user = User.new
    
    #user.email = params.fetch("input_email")
    #user.username = params.fetch("input_username")
    #user.password = params.fetch("input_password")
    #user.password_confirmation = params.fetch("input_password_confirmation")

    #save_status = the_user.save

    #if save_status == true
      #session.store(:user_id, user.id)

     # redirect_to("/users/#{user.username}", {:notice => "Signed in successfully."})
    #else
      #redirect_to("/user_sign_up", {:alert => user.errors.full_messages.to_sentence})
    #end
  end


  def update
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)
    the_user.comments_count = params.fetch("query_comments_count")
    the_user.email = params.fetch("query_email")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.password_digest = params.fetch("query_password_digest")
    the_user.private = params.fetch("query_private", false)
    the_user.username = params.fetch("query_username")

    if the_user.valid?
      the_user.save
      redirect_to("/users/#{the_user.id}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{the_user.id}", { :alert => "User failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.destroy

    redirect_to("/users", { :notice => "User deleted successfully."} )
  end

  def authenthicate

    # get the username
    #em = params.fetch("query_email")
    # get the password
    #pw = params.fetch("query_password")

    # look up the record
    #user = User.where({:email => em}).at(0)
    # if there's no record, redirect back to sign in form
    #if user == nil
      #redirect_to("/user_sign_in", {:alert => "No user found with these credentials"})
    #else 
      # if there is a record, check to see if password matches
      #if user.authenticate(pw)
        #session.store(:user_id, user.id)
      if session.fetch(:user_id) != nil
        redirect_to("/", {:notice => "Signed in successfully."})
        # if not, redirect back to sign in form
      else
        redirect_to("/user_sign_in", {:alert => "Wrong credentials"})
      end
    #end
  end

  def create_cookie
    user = User.where({ :email => params.fetch("query_email") }).first
    
    the_supplied_password = params.fetch("query_password")
    
    if user != nil
      are_they_legit = user.authenticate(the_supplied_password)
    
      if are_they_legit == false
        redirect_to("/user_sign_in", { :alert => "Incorrect password." })
      else
        session[:user_id] = user.id
      
        redirect_to("/", { :notice => "Signed in successfully." })
      end
    else
      redirect_to("/user_sign_in", { :alert => "No user with that email address." })
    end
  end





  def toast_cookies
    reset_session

    redirect_to("/", { :notice => "Signed out successfully." })

  end
  
  
  def new_registration_form

    render({ :template => "users/user_signup_form.html.erb"} )
  end
  
  def new_session_form
    render({ :template => "users/user_signin_form.html.erb"} )
  end

  def modify_user
    the_id = params.fetch("path_id")

    matching_users = User.where({ :username => the_id })

    @the_user = matching_users.at(0)

    render({ :template => "users/edit_user_profile.html.erb"} )
  end


end
