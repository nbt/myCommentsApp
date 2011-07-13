== Create a Heroku-ready Rails 3 app with unobtrusive Javascript using jQuery

Basic setup for a new Rails app.  We specify postgresql since that's what
Heroku requires.

1. <tt>rails new myCommentsApp --database=postgresql --skip-prototype --skip-test-unit</tt>
2. <tt>cd myCommentsApp</tt>
3. <tt>rm public/index.html</tt>
4. <tt>git init</tt>
5. <tt>git commit -m 'initial commit'</tt>

Now we create the Comment model and prepare the app to use jQuery rather than
the prototype.js framework.

6. <tt>rails generate resource Comment name:string body:text</tt>
7. Edit Gemfile to read:

  # file: Gemfile
  source 'http://rubygems.org'

  gem 'rails', '3.0.5'
  gem 'rake', '0.8.7'             # workaround "uninitialized constant Rake::DSL" bug
  gem 'pg', '0.11.0'
  gem 'jquery-rails', '1.0.12'

  group :development, :test do
    gem 'rspec', '2.6.0'
    gem 'rspec-rails', '2.6.1'
  end

8. Generate bundle file.  Note that there's a conflict with rake 0.9.2
and rails 3.0.5, so we need to specify rake 0.8.7 instead: <tt>bundle
update rake</tt>

9. <tt>rails generate jquery:install</tt>

10. Comment out the line in config/application.rb that reads:

  # JavaScript files you want as :defaults (application.js is always included).
  # config.action_view.javascript_expansions[:defaults] = %w()

11. Set up the initial database:

  % rake db:create
  % rake db:migrate

Now we start filling in the application-specific files.

12. Create app/controllers/comments_controller.rb:

  class CommentsController < ApplicationController

    def index
      @comments = Comment.all
      # index.html.erb
    end

    def create
      @comment = Comment.create!(params[:comment])
      flash[:notice] = "Thanks for commenting!"
      respond_to do |format|
        format.html { redirect_to comments_path } # index.html.erb
        format.js                                 # create.js.erb
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to comments_path } # index.html.erb
        format.js                                 # destroy.js.erb
      end
    end

  end

13. Create app/views/comments/_comment.html.erb:

  <%= div_for comment do %>
    <span class="dateandoptions">
      Posted <%= time_ago_in_words(comment.created_at) %> ago
      <%= tag(:br) %>
      <%= link_to 'Delete', comment_path(comment), :method => :delete, :class => "delete", :remote => true  %>
    </span>
    <%= content_tag(:p, content_tag(:b, comment.name) + " wrote:") %>
    <%= tag(:br) %>
    <%= content_tag(:p, comment.body, :class => "comment-body") %>
  <% end %>

14. Create app/views/comments/create.js.erb:

  /* Insert a notice between the last comment and the comment form */
  $("#comment-notice").html('<div class="flash notice"><%= escape_javascript(flash.delete(:notice)) %></div>');

  /* Replace the count of comments */
  $("#comments_count").html("<%= pluralize(Comment.count, 'Comment') %>");

  /* Add the new comment to the bottom of the comments list */
  $("#comments").append("<%= escape_javascript(render(@comment)) %>");

  /* Highlight the new comment */
  $("#comment_<%= @comment.id %>").effect("highlight", {}, 3000);

  /* Reset the comment form */
  $("#new_comment")[0].reset();

15. Create app/views/comments/destroy.js.erb

  /* Eliminate the comment by fading it out */
  $('#comment_<%= @comment.id %>').fadeOut();

  /* Replace the count of comments */
  $("#comments_count").html("<%= pluralize(Comment.count, 'Coment') %>");

16. Create app/views/comments/index.html.erb

  <h2>Comments</h2>
  <%= content_tag(:span, pluralize(@comments.count, "comment"), :id => "comments_count") %>
  <%= content_tag(:div, render(@comments), :id => "comments") %>
  <%= tag(:hr) %>
  <%= content_tag(:div, '', :id => "comment-notice") %>

  <h2>Say something!</h2>
  <%= form_for Comment.new, :remote => true do |f| %>
          <%= f.label :name, "Your name" %><br />
          <%= f.text_field :name %><br />
          <%= f.label :body, "Comment" %><br />
          <%= f.text_area :body, :rows => 8 %><br />
          <%= f.submit "Add comment" %>
  <% end %>

17. Edit config/routes.rb so the root path points to the comments controller:

  MyCommentsApp::Application.routes.draw do
    resources :comments
    root :to => "comments#index"
  end

18. Create public/stylesheets/application.css

  body
  {
    background-color: #fff;
    color: #444;
    margin: 20px;
    padding: 20px;
  }

  body, p, ol, ul, td
  {
    font-family: "Myriad Pro","Myriad Web", helvetica, sans-serif;
    font-size:   14px;
  }

  .small
  {
    font-size: 12px;
  }

  h3
  {
    font-size: 20px;
  }

  h3 a
  {
    text-decoration: none;
  }

  pre
  {
    background-color: #eee;
    padding: 10px;
    font-size: 11px;
  }

  a { color: #444; }
  a:visited { color: #444; }
  a:hover { color: #980000; }

  div.field, div.actions
  {
    margin-bottom: 10px;
  }

  .fieldWithErrors
  {
    padding: 2px;
    background-color: red;
    display: table;
  }

  #errorExplanation
  {
    width: 400px;
    border: 2px solid red;
    padding: 7px;
    padding-bottom: 12px;
    margin-bottom: 20px;
    background-color: #f0f0f0;
  }

  #errorExplanation h2
  {
    text-align: left;
    font-weight: bold;
    padding: 5px 5px 5px 15px;
    font-size: 12px;
    margin: -7px;
    background-color: #c00;
    color: #fff;
  }

  #errorExplanation p
  {
    color: #333;
    margin-bottom: 0;
    padding: 5px;
  }

  #errorExplanation ul li
  {
    font-size: 12px;
    list-style: square;
  }

  div.flash.notice
  {
    display: block;
    padding: 10px;
    border: 1px solid #3A991A;
    background-color: #ABD7A4;
    margin: 20px 10px;
    color: #000000;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;
  }

  .comment
  {
    display: block;
    background: #E5EEED;
    -moz-border-radius: 5px;
    -webkit-border-radius: 5px;
    border-radius: 5px;
    padding: 10px;
    margin: 10px;
  }

  .dateandoptions
  {
          float:right;
          color:gray;
          text-align:right;
  }

== Deploy on Heroku

  % heroku create --stack cedar
  % git push heroku master
  % heroku run rake db:create
  % heroku run rake db:mugrate
  % heroku open
