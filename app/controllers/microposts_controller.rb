class MicropostsController < ApplicationController
# before_action :logged_in_user, only: [:create]  
 
  def create
   @carid = Carid.find(params[:micropost][:carid_id])
   @micropost = @carid.microposts.build(micropost_params)
   if @micropost.save
     flash[:success] = "Micropost created!" 
     redirect_to root_url(carid: @carid.id)
   else
     render 'static_pages/home', carid: @carid.id
   end
  end
  
  def destroy
   @micropost = current_user.microposts.find_by(id: params[:id])
   return redirect_to root_url if @micropost.nil?
   @micropost.destroy
   flash[:success] = "Micropost deleted"
   redirect_to request.referrer || root_url
  end
  
  private
  def micropost_params
   params.require(:micropost).permit(:content, :kind, :lat, :lng, :accuracy, :carid_id, :logtime)
  end
end 
    
