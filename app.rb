require 'sinatra'
require 'grim'

get '/:pdf_path/?:page?' do
  pdf_path = File.basename(params[:pdf_path])
  page = params[:page] ? params[:page].to_i : 0

  pdf = Grim.reap("#{pdf_path}.pdf")
  count = pdf.count

  halt 404 if page >= count

  png = pdf[page].save("#{pdf_path}.png")

  return send_file("#{pdf_path}.png", type: 'image/png', disposition: 'inline')
end