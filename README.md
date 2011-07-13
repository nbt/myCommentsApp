# myCommentsApp

Create a Heroku-ready Rails 3 app with unobtrusive Javascript using jQuery

Based on [bernat/myCommentsApp](https://github.com/bernat/myCommentsApp).

## Step 1: Create a new Rails app.

We specify postgresql since that is the database supported by Heroku

    % rails new myCommentsApp --database=postgresql --skip-prototype --skip-test-unit
    % cd myCommentsApp
    % rm public/index.html
    % git init
    % git commit -m 'initial commit'

## Step 2: Prepare the app for the Comment resource and jquery

    % rails generate resource Comment name:string body:text

Edit Gemfile to include postgresql and jquery.  I also use rspec in prerefence
to the default test framework.  Finally, notice that we specify rake 0.8.7 in
order to avoid an 'unititialized constant Rake::DSL' error:

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

Generate the bundle file.  The +bundle update rake+ step is required to
override the existing rake gem.

    % bundle update rake
    % bundle install

Use the jquery generator to replace the prototype.js mechanism with jquery.js:

    % rails generate jquery:install

Comment out the line in config/application.rb that reads:

    config.action_view.javascript_expansions[:defaults] = %w()
    
so that it reads

    # config.action_view.javascript_expansions[:defaults] = %w()

Set up the initial database:

    % rake db:create
    % rake db:migrate

## Step 3: Fill in the application-specific files

From this git respository, copy or transcribe the following files:

    app/controllers/comments_controller.rb
    app/views/comments/_comment.html.erb
    app/views/comments/create.js.erb
    app/views/comments/destroy.js.erb
    app/views/comments/index.html.erb
    public/stylesheets/application.css
    public/stylesheets/grid.css

Edit config/routes.rb to set up the root path:

    MyCommentsApp::Application.routes.draw do
      resources :comments
      root :to => "comments#index"
    end

## Step 4: Test on your local machine

    % rails server

Direct your browser to [localhost:3000](localhost:3000) and verify that you can post and delete comments.

If all is working, you are ready to push your application to Heroku.

## Step 4: Push to heroku

    % heroku create --stack cedar
    % git push heroku master
    % heroku run rake db:create
    % heroku run rake db:mugrate
    % heroku open
