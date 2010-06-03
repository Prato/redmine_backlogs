class BacklogsGlobalController < ApplicationController
  unloadable

  before_filter :authorize_global

  def statistics
    @projects = EnabledModule.find(:all,
                                :conditions => ["enabled_modules.name = 'backlogs' and status = ?", Project::STATUS_ACTIVE],
                                :include => :project,
                                :joins => :project).collect { |mod| mod.project }
    @projects.sort! {|a, b| a.scrum_statistics[:score][:score] <=> b.scrum_statistics[:score][:score]}
    
    render :action => 'statistics'
  end

  private

end
