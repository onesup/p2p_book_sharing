module VillagesHelper
  def put_si_gu
    params[:si] + " " + params[:gu]
  end
  
  def put_gu_dong
    params[:gu] + " " + params[:dong]
  end
end
