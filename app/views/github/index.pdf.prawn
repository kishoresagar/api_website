prawn_document() do |pdf|
    @gits.each do |f|
     pdf.text f.name
    end
end