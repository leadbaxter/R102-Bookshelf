module Bookshelf
  class ProjectContentsController < ApplicationController

    before_filter :check_params, :only => [:create]
    
    # GET /project_contents
    # GET /project_contents.json
    def index
      @project = Project.find(params[:project_id])
      @contents = @project.contents.all
      respond_to do |format|
        format.html { render :text => "project: #{@project.name}, count: #{@contents.count}"} # index.html.haml
        format.json { render :json => @contents }
        format.xml  { render :xml => @project }
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
      #t.references :project
      #t.string :created_by  # user email
      #t.text :body
      #t.text :comments
      @project = find_project
      respond_to do |format|
        format.xml {
          if save_content
            render :text => @content.body, :content_type => 'application/xml'
          else
            render :text => @errors_xml, :status => :unprocessable_entity
          end
        }
      end
    end

  private
    def clip_value sym, init_obj, fld
      param_obj = params[:project][:metadata][sym]
      @project_metadata[sym][fld] = param_obj[fld]
      if fld == :id and param_obj[fld] == init_obj[fld]
        @project_metadata[sym][:new] = true
      end
    end

    def clip_object sym
      (@project_metadata ||= {})[sym] = {}
      init_obj = {
          id: "**cloud_#{sym}_id**", name: "**cloud #{sym}**"
      }
      clip_value(sym, init_obj, :id)
      clip_value(sym, init_obj, :name)
    end

    # Process the params. Indicate an error if the params don't have project metadata.
    def check_params
      if params[:project] and params[:project][:metadata]
        @project_xml = request.body.read
        #params[:project][:metadata][:project][:id] = 16
        clip_object :project
        clip_object :owner
        meta_owner = @project_metadata[:owner]
        meta_project = @project_metadata[:project]
        puts "project metadata [owner_id=#{meta_owner[:id]}, owner_name=#{meta_owner[:name]}, project_id=#{meta_project[:id]}, project_name=#{meta_project[:name]}]"
        puts "this is a new project" if @project_metadata[:project][:new]
        @errors_xml = nil
      else
        @errors_xml = "error: project metadata is absent!"
      end
    end

    def find_project
      if @errors_xml.present?
        nil
      else
        meta_owner = @project_metadata[:owner]
        meta_project = @project_metadata[:project]
        if meta_project[:new]
          #t.string :name
          #t.string :created_by
          #t.string :content_id
          #t.boolean :archived
          Bookshelf::Project.new({ name: meta_project[:name], created_by: meta_owner[:id]})
        else
          Bookshelf::Project.find(meta_project[:id])
        end
      end
    end

    # Update the project's xml representation with the obj's project/owner id and name, if the project metadata
    # indicates the project (in params) was a new project.
    def update_xml sym, obj
      obj.each do |k,v|
        the_metadata = @project_metadata[sym]
        if the_metadata[:new]
          pat = the_metadata[k].to_s.gsub /\*/, '\*'
          @project_xml.sub! /#{pat}/, v.to_s
        end
      end
    end

    # If the project is new, save it and update the xml to reflect the project.id; otherwise do nothing.
    def save_project
      if !@project.new_record?
        true
      else
        @project.save.ifTrue do
          meta_project = @project_metadata[:project]
          meta_owner = @project_metadata[:owner]
          update_xml :project, :id => @project.id, :name => meta_project[:name]
          update_xml :owner,   :id => @project.id, :name => meta_owner[:name]
        end
      end
    end

    # Save the project content after saving the project if it needs to be saved.
    def save_content
      if save_project
        meta_owner = @project_metadata[:owner]
        @content = Bookshelf::ProjectContent.new({ project_id: @project.id, body: @project_xml, created_by: meta_owner[:id] })
        @content.save
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
