class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :ensure_logged_in, except: [:index, :show]

  # AUTHENTICATION FOR EVENT DELETION CURRENTLY WEAK, USER_ID COMPARISON

  # Currently shows all of the plans that have been made.
  # Does not currently support different users.
  def index
    @plans = Plan.all
  end

  # Each create event has the following link: /plans/1, etc.
  # Also fetches the json associated with the event
  def show
  end

  # Only a user who is logged in is allowed to create a plan.
  def new
    @plan = current_user.plans.build
  end

  # Attempts to edit the event. Includes authentication check.
  def edit
    if @plan.user_id != current_user.id
      flash[:notice] = "You are not authorized to update this event."
      redirect_to plans_url
    end
  end

  # Create an event and bind it to the current user.
  def create
    @plan = current_user.plans.build(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # Edit link directs to update function.
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete a plan. Currently does an authentication check when the function is called.
  # ** REVISE LOGIC **
  def destroy
    if @plan.user_id != current_user.id
      flash[:notice] = "You are not authorized to delete this event"
      redirect_to plans_url
    else
      @plan.destroy
      respond_to do |format|
        format.html { redirect_to plans_url, notice: 'Event was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:name, :start_time, :end_time)
    end
end
