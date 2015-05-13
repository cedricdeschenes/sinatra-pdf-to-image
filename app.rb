require 'sinatra'
require 'grim'

get '/:pdf_path/?:page?' do
  pdf_path = params[:pdf_path]
  page = params[:page] ? params[:page].to_i : 0

  pdf = Grim.reap("#{pdf_path}.pdf")
  count = pdf.count

  if page >= count
    halt 404
  end

  png = pdf[page].save("#{pdf_path}.png")

  send_file "#{pdf_path}.png", type: 'image/png', disposition: 'inline'
end