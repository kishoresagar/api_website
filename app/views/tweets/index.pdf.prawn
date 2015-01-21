prawn_document() do |pdf|
    @tweets.each do |f|
     pdf.text f.username
      pdf.text f.text
    end
end
