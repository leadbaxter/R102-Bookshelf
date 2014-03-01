module Bookshelf

  class ProjectsController < ApplicationController

    load_and_authorize_resource :class => 'Bookshelf::Project' # cancan authorizes that the user has access to the project resources

    # GET /projects
    # GET /projects.json
    def index
      respond_to do |format|
        format.html # index.html.haml
        format.json { render :json => error_code, :status => :unprocessable_entity }
      end
    end

    # GET /projects/1
    # GET /projects/1.json
    def show
      respond_to do |format|
        format.html # show.html.erb
        format.json { render :json => @project }
      end
    end
  
    # GET /projects/new
    # GET /projects/new.json
    def new
      respond_to do |format|
        format.html # new.html.haml
        format.json { render :json => @project }
      end
    end
  
    # GET /projects/1/edit
    def edit
    end
  
    # POST /projects
    # POST /projects.json
    def create
      respond_to do |format|
        if @project.save
          format.html { redirect_to @project, :notice => 'Project was successfully created.' }
          format.json { render :json => @project, :status => :created, :location => @project }
        else
          format.html { render :action => "new" }
          format.json { render :json => @project.errors, :status => :unprocessable_entity }
        end
      end
    end
  
    # PUT /projects/1
    # PUT /projects/1.json
    def update
      respond_to do |format|
        if @project.update_attributes(params[:project])
          format.html { redirect_to @project, :notice => 'Project was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @project.errors, :status => :unprocessable_entity }
        end
      end
    end
  
    # DELETE /projects/1
    # DELETE /projects/1.json
    def destroy
      @project.destroy
  
      respond_to do |format|
        format.html { redirect_to projects_url }
        format.json { head :ok }
      end
    end
  end
end
