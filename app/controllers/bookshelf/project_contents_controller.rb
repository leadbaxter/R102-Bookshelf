module Bookshelf
  class ProjectContentsController < ApplicationController

    # GET /project_contents
    # GET /project_contents.json
    def index
      @project = Project.find(params[:project_id])
      @contents = @project.contents.all
      respond_to do |format|
        format.html { render :text => "project: #{@project.name}, count: #{@contents.count}"} # index.html.haml
        format.json { render :json => @contents }
      end
    end

    # GET /project_contents/1
    # GET /project_contents/1.json
    def show
      @contents = ProjectContent.find[:project_content_id]
      respond_to do |format|
        format.html # index.html.haml
        format.json { render :json => @contents }
      end
    end

    # GET /project_contents/new
    # GET /project_contents/new.json
    def new
    end

    # GET /project_contents/1/edit
    def edit
    end

    # POST /project_contents
    # POST /project_contents.json
    def x_create
      @project = Project.find(params[:project_id])
      @body = @project.contents.create(params[:content])
      redirect_to project_path(@project)
    end

    def create
      respond_to do |format|
        #format.xml { render xml: Struct.new(:message, :status).new("Fake project status", true) }
        #format.xml { render xml: { message: "Fake project status", status: true } }
        format.xml {
          if params[:project] and params[:project][:metadata]
            the_project = params[:project]
            the_owner_id = the_project[:metadata][:owner][:id]
            the_owner_name = the_project[:metadata][:owner][:name]
            the_project_id = the_project[:metadata][:project][:id]
            the_project_name = the_project[:metadata][:project][:name]
            puts "project metadata [owner_id=#{the_owner_id}, owner_name=#{the_owner_name}, project_id=#{the_project_id}, project_name=#{the_project_name}]"
          else
            puts "project metadata is absent!"
          end
          render :text => request.body.read, :content_type => 'application/xml'
        }
      end
    end


    #def projects
    #  respond_to do |format|
    #    format.xml { render xml: Part.all }
    #  end
    #end
    #
    #def project
    #  respond_to do |format|
    #    format.xml { render xml: Part.all }
    #  end
    #end
    #
  end
end
