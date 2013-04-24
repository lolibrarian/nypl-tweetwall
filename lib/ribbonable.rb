module Ribbonable
  def ribbon?
    ribbon_label.present?
  end

  def ribbon_label
    nil
  end
end
