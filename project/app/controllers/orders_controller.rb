class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end
  
  
  def bookneworder
  
   if Cart.where({user_id: current_user.id}).empty?
  	redirect_to blogs_url, :notice => 'cart empty'
  	return
  end
  

# if Cart.select('*').where({'carts.user_id' => current_user.id}).joins("inner join  blogs on blogs.id=carts.blog_id").empty?

m=Cart.select('carts.*,blogs.*,carts.user_id as cartuser,blogs.user_id as business_id,carts.blog_id as deleid').where({'carts.user_id' => current_user.id}).joins("inner join  blogs on blogs.id=carts.blog_id")

puts m.first.image
puts m.first.cartuser
puts m.first.business_id

k=[]
m.each do |t|
  if(!k.include?(t.business_id))
    k.push(t.business_id)
    end
end
    puts k
    
k.each do |t|
  @order = Order.new()
  @book=Book.find(params[:bookid])
  @order.order_name=@book.bookname
  @order.order_mobile=@book.bookmobile
  @order.order_address=@book.bookaddress
  @order.user=current_user
  @order.order_status='未付款'
  @order.business_id=t
  if !@order.save
  respond_to do |format|
      format.html { redirect_to new_order_url, notice: "请检查信息填写完整，手机号格式正确" }
      format.json { head :no_content }
       
    end
    return
  
  end
  
  tmpsum=0.0
  
  m.each do |v|
	  if(v.business_id==t)
	  
	  puts 'xxxxx'
	  
	    @orderitem=Orderitem.new()
	    @orderitem.order_id=@order.id
	    @orderitem.price=v.price
	    @orderitem.num=v.num
	    @orderitem.image=v.image
	    @orderitem.title=v.title
	    @orderitem.save
	    
	    @tmpblogc=Blog.find(v.deleid)
	    @tmpblogc.stock=@tmpblogc.stock-v.num
	    @tmpblogc.sales=@tmpblogc.sales+v.num
	    @tmpblogc.save
	
	    tmpsum+=v.num*v.price
	  end
  end
  @order.order_sum=tmpsum
  @order.save
  
  

  
end
mde=Cart.select('*').where({'carts.user_id' => current_user.id})
mde.each do |t|
  t.destroy

end

    #@order = Order.new(order_params)
    #@order.user=current_user
   # @order.status='未发货'
    
    redirect_to orders_url, :notice => 'order success'
    
  
  
  
  end
  
  
  

  # POST /orders or /orders.json
  def create
  
  if Cart.where({user_id: current_user.id}).empty?
  	redirect_to blogs_url, :notice => 'cart empty'
  	return
  end
  

# if Cart.select('*').where({'carts.user_id' => current_user.id}).joins("inner join  blogs on blogs.id=carts.blog_id").empty?

m=Cart.select('carts.*,blogs.*,carts.user_id as cartuser,blogs.user_id as business_id,carts.blog_id as deleid').where({'carts.user_id' => current_user.id}).joins("inner join  blogs on blogs.id=carts.blog_id")

puts m.first.image
puts m.first.cartuser
puts m.first.business_id

k=[]
m.each do |t|
  if(!k.include?(t.business_id))
    k.push(t.business_id)
    end
end
    puts k
    
k.each do |t|
  @order = Order.new(order_params)
  @order.user=current_user
  @order.order_status='未付款'
  @order.business_id=t
  if !@order.save
  respond_to do |format|
      format.html { redirect_to new_order_url, notice: "请检查信息填写完整，手机号格式正确" }
      format.json { head :no_content }
       
    end
    return
  
  end
  
  tmpsum=0.0
  
  m.each do |v|
	  if(v.business_id==t)
	  
	  puts 'xxxxx'
	  
	    @orderitem=Orderitem.new()
	    @orderitem.order_id=@order.id
	    @orderitem.price=v.price
	    @orderitem.num=v.num
	    @orderitem.image=v.image
	    @orderitem.title=v.title
	    @orderitem.save
	    
	    @tmpblogc=Blog.find(v.deleid)
	    @tmpblogc.stock=@tmpblogc.stock-v.num
	    @tmpblogc.sales=@tmpblogc.sales+v.num
	    @tmpblogc.save
	
	    tmpsum+=v.num*v.price
	  end
  end
  @order.order_sum=tmpsum
  @order.save
  
  

  
end
mde=Cart.select('*').where({'carts.user_id' => current_user.id})
mde.each do |t|
  t.destroy

end

    #@order = Order.new(order_params)
    #@order.user=current_user
   # @order.status='未发货'
    
    redirect_to orders_url, :notice => 'order success'
    

    #respond_to do |format|
   #   if @order.save
   #     format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
   #     format.json { render :show, status: :created, location: @order }
   #   else
   #     format.html { render :new, status: :unprocessable_entity }
   #     format.json { render json: @order.errors, status: :unprocessable_entity }
   #   end
   # end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def alterstatus
  @order=Order.find(params[:id])
  t=@order.order_status
  
  
if t=='未付款' then
    @order.order_status='未发货'
  elsif t=='未发货' then
  @order.order_status='未收货'

      elsif t=='未收货' then
    @order.order_status='已收货'
    
  end
 # else if t=='已删除并退款'
  
  
  respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: "订单状态修改成功" }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
    end

  # DELETE /orders/1 or /orders/1.json
  def destroy
   # @order.destroy
    @order.order_status='已删除并退款'
    @order.save

  #  respond_to do |format|
  #    format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
  #    format.json { head :no_content }
  #  end
    
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: "商品已成功删除并退款" }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :business_id, :order_name, :order_address, :order_mobile, :order_status, :order_sum)
    end
end
