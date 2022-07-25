module ApplicationHelper
  def flash_class(level)
    return 'alert alert-danger' if level == 'danger'

    'alert alert-success'
  end
end
