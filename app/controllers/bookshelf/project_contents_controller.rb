module Bookshelf
  class ProjectContentsController < ApplicationController

    before_filter :check_params, :only => [:create]

    # GET /project_contents      # response is all project contents (html)
    # GET /project_contents.json # response is all project contents (json)
    #
    # GET /project_contents.xml?project_number=00001 # response is project.project_content.body (last, xml)
    # GET /project_contents.json?project_number=00001 # response is project.project_content.body (last)
    #
    # GET /project_contents.xml?project_key={KEY} # response is project.project_content.body (last, xml)
    # GET /project_contents.json?project_key={KEY} # response is project.project_content.body (last)
    #
    def index
      @contents = if params[:project_id].present?
        @project = Project.find(params[:project_id])
        @project.contents.all
      elsif params[:project_number].present?
        @project = Project.find_by_project_number(params[:project_number])
        ProjectContent.find_all_by_project_id(@project.id, :order => :created_at).last
      elsif params[:project_key].present?
        @project = Project.find_by_project_key(params[:project_key])
        ProjectContent.find_all_by_project_id(@project.id, :order => :created_at).last
      else
        ProjectContent.all
      end
      respond_to do |format|
        format.html
        format.json { render :json => @contents }
        format.xml  { render :xml => @contents.body }
      end
    end

    # GET /project_contents/1
    # GET /project_contents/1.json
    def show
      @contents = ProjectContent.find params[:id]
      respond_to do |format|
        format.html # index.html.haml
        format.json { render :json => @contents }
        format.xml  { render :xml => @contents }
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
    # POST /project_contents.xml
    def create
      saved = save_project
      respond_to do |format|
        format.xml {
          if saved
            render :xml => @result.to_xml(root: 'project')
          else
            render :text => @errors_xml, :status => :unprocessable_entity
          end
        }
      end
    end

  private
    require 'bookshelf/save_project_contents'
    include SaveProjectContents
  end
end
