class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]

  # GET /books or /books.json
  def index
    @books = Book.all
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
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
  @book=Book.find(params[:id])
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

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { redirect_to new_book_url, notice: "请检查信息填写完整，手机号格式正确" }
      format.json { head :no_content }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { redirect_to edit_book_url(@book), notice: "请检查信息填写完整，手机号格式正确" }
      format.json { head :no_content }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:user_id, :bookname, :bookaddress, :bookmobile)
    end
end
