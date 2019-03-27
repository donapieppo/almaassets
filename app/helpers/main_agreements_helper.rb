module MainAgreementsHelper
  def main_agreement_description(ma)
    ma.split(';').map do |line|
      (n, v) = line.split('#')
      "<strong>#{h n}</strong>: #{h v}".html_safe
    end.join('<br/>').html_safe
  end
end
