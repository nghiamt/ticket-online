class OrderLinesController < ApplicationController
  before_action :set_order_line, only: [:show, :edit, :update, :destroy]

  # GET /order_lines
  # GET /order_lines.json
  def index
    @order_lines = current_user.pending_order.order_lines.where("quantity > ?", 0)
    @order = current_user.pending_order
  end

  # GET /order_lines/1
  # GET /order_lines/1.json
  def show
  end

  # GET /order_lines/new
  def new
    @order_line = OrderLine.new
  end

  # GET /order_lines/1/edit
  def edit
  end

  # POST /order_lines
  # POST /order_lines.json
  def create
    order = current_user.pending_order
    @order_line = order.order_lines.find_or_create_by(ticket_id: params[:ticket_id])
    old_quantity = @order_line.quantity.to_i
    base_quantity =  params[:type] == "add" ? @order_line.quantity.to_i : 0
    @order_line.quantity = base_quantity + params[:quantity].to_i

    respond_to do |format|
      if @order_line.save
        total_amount = order.total_amount.to_i + @order_line.ticket.price * (params[:quantity].to_i - old_quantity)
        order.update total_amount: total_amount
        format.html { redirect_to @order_line, notice: 'Order line was successfully created.' }
        format.json { render :show, status: :created, location: @order_line }
        format.js
      else
        format.html { render :new }
        format.json { render json: @order_line.errors, status: :unprocessable_entity }
        format.js do
          @errors = @order_line.errors
          render "layouts/errors"
        end
      end
    end
  end

  # PATCH/PUT /order_lines/1
  # PATCH/PUT /order_lines/1.json
  def update
    old_quantity = @order_line.quantity.to_i
    @order_line.quantity = params[:quantity].to_i
    respond_to do |format|
      if @order_line.save
        total_amount = order.total_amount.to_i + @order_line.ticket.price * (params[:quantity].to_i - old_quantity)
        order.update total_amount: total_amount
        format.html { redirect_to @order_line, notice: 'Order line was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_line }
        format.js {render "create"}
      else
        format.html { render :edit }
        format.json { render json: @order_line.errors, status: :unprocessable_entity }
        format.js do
          @errors = @order_line.errors
          render "layouts/errors"
        end
      end
    end
  end

  # DELETE /order_lines/1
  # DELETE /order_lines/1.json
  def destroy
    @order_line.destroy
    respond_to do |format|
      format.html { redirect_to order_lines_url, notice: 'Order line was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_line
      @order_line = OrderLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_line_params
      params.fetch(:order_line, {})
    end
end
