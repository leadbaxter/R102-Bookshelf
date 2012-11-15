#
# Methods for saving project contents (used by the :create action.)
module Bookshelf
  module SaveProjectContents
    def project_metadata
      params[:project][:metadata]
    end

    def meta_project
      project_metadata[:project]
    end

    def meta_owner
      project_metadata[:owner]
    end

    def project_mod_date
      params[:project].try(:[], :modDate).try(:[], :value).to_i
    end

    # Process the params. Set the error indicator if the params don't have project metadata.
    def check_params
      if params[:project] and project_metadata
        @project_xml = request.body.read
        puts "project metadata [owner_id=#{meta_owner[:id]}, owner_name=#{meta_owner[:name]}, project_id=#{meta_project[:id]}, project_name=#{meta_project[:name]}]"
        @errors_xml = nil
      else
        @errors_xml = "error: project metadata is absent!"
      end
    end

    # If the project needs to be saved, save it
    def save_project
      @result = {}
      if find_project
        @result.merge!("new_project_inserted" => true) if @project.new_record?
        init_project_mod_date
        @project.save and save_content
      end
    end

    # Answer the project found identified by the project number, creating a new one if necessary.
    def find_project
      unless @errors_xml.present?
        @project = Bookshelf::Project.find_by_project_number(meta_project[:id]) || Bookshelf::Project.new({
            project_number: meta_project[:id],
            project_name: meta_project[:name],
            created_by: meta_owner[:id]
        })
      end
    end

    # Answer true if the project's mod_date is out of date in respect to the mod_date of the POSTed content.
    def project_out_of_date?
      @project.new_record? or @project.mod_date.blank? or @project.mod_date < project_mod_date.to_i
    end

    def init_project_mod_date
      @project_mod_date = if project_out_of_date?
        @project.mod_date = project_mod_date
        @result.merge! "new_project_mod_date" => @project.mod_date.to_i
      else
        @result.merge! "project_mod_date" => @project.mod_date.to_i, "message" => "project already up to date"
        nil
      end
    end

    # Add a ProjectContent record, but only if the mod_date was updated.
    def save_content
      return true unless @result["new_project_mod_date"].present?
      @content = Bookshelf::ProjectContent.new({
        project_id: @project.id,
        body: @project_xml,
        created_by: meta_owner[:id]
      })
      (!!@content.save).ifTrue { @result.merge! "new_content_inserted" => true }
    end
  end
end