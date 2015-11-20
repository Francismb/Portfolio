class ProjectsController < ApplicationController

  # Require authentication for the following functions
  before_action :require_authentication, :only => [
      :new, :create,
      :edit, :update,
      :delete, :destroy
  ]

  # Lists all the projects.
  # GET http://francismb.com/projects
  def index
    @projects = logged_in ? Project.all : Project.where(:visible => true)
  end

  # Shows the contents of a project.
  # GET http://francismb.com/projects/show?id=?
  def show
    @project = logged_in ? Project.find(params[:id]) : Project.where(:id => params[:id]).where(:visible => true).first
  end

  # Shows the form to make a new project.
  # Requires authentication.
  # GET http://francismb.com/projects/new
  def new
  end

  # Processes the form sent from the action #new and
  # creates a new project if the information is valid.
  # Requires authentication.
  # POST http://francismb.com/projects/create
  def create
    @project = Project.new(project_params)
    if @project.validate && @project.save
      redirect_to :action => :show, :id => @project.id
    else
      @errors = @project.errors
      render :action => :new
    end
  end

  # Shows the form to edit a persisted project
  # Requires authentication.
  # GET http://francismb.com/projects/edit?id=?
  def edit
    @project = Project.find(params[:id])
  end

  # Processes the form sent from the action #edit and
  # updates the project if the information is valid.
  # Requires authentication.
  # PUT http://francismb.com/projects/update
  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to :action => :show, :id => @project.id
    else
      @errors = @project.errors
      render :action => :edit
    end
  end

  # Confirms if you want to delete a project.
  # Requires authentication.
  # GET http://francismb.com/projects/delete?id=?
  def delete
    @project = Project.find(params[:id])
  end

  # Deletes a persisted project from the database.
  # Requires authentication.
  # DELETE http://francismb.com/projects/id=?
  def destroy
    project = Project.find(params[:id])
    if project
      project.delete
    end
    redirect_to :action => :index
  end

end
