require 'rubygems'
require 'tmail'
require 'pop_ssl' 

class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    @products = Product.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @products }
    end
  end
  
  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)  
    Net::POP3.start('pop.gmail.com', 995, "vestisource","Test123@") do |pop|  
      unless pop.mails.empty?
        pop.each_mail do |mail|  
          email = TMail::Mail.parse(mail.pop)
          @product.emailfrom = email.from
        end 
      end
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @product }
    end
  end
  
  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @product }
    end
  end
  
  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end
  
  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])
    
    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])
    
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    
    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml { head :ok }
    end
  end
    
end
