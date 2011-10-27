module FirmsHelper
  def firm_name firm
    firm.short_name.present? ? firm.short_name : firm.name
  end
end
