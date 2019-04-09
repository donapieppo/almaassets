module PrintHelper
  def docx_header(docx)
    logopath = "#{Rails.root}/app/assets/images/sigillo1.png"
    docx.img logopath do
      width  50
      height 50
      align :center
    end
    
    docx.p "ALMA MATER STUDIORUM - UNIVERSITÀ DI BOLOGNA", align: :center, bold: true
    docx.p "Dipartimento di Matematica", align: :center, bold: true
  end

  def letter_defaults(docx)
    full_size  = 20
    small_size = 12

    docx.style do
      id   'Normal'
      name 'Normal'
      font 'Serif'
      size full_size
      line 300 
    end

    docx.page_margins do
      left    800     # sets the left margin. units in twips.
      right   800     # sets the right margin. units in twips.
      top     600    # sets the top margin. units in twips.
      bottom  600    # sets the bottom margin. units in twips.
    end
  end

end
