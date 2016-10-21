class Chore < ActiveRecord::Base
  belongs_to :child
  belongs_to :task
  
  validates_date :due_on
  
  scope :done, -> { where('completed is ?', true) }
  scope :pending, -> { where('completed is ?', false) }
  scope :upcoming, -> { where('due_on >= ?', Date.today)}
  scope :past, -> { where('due_on < ?', Date.today) }
  
  #OMG THIS WAS SO HARD
  scope :by_task, -> { joins(:task).order('name') }
  scope :chronological, -> { joins(:task).order('due_on') }
  
  def status
    if completed == true
      'Completed'
    else
      'Pending'
    end
  end

end
