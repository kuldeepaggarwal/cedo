class OrdersController < ApplicationController
  def schedule
    start_date = params[:start_date].presence
    end_date = params[:end_date].presence

    if start_date && end_date
      OrderProcessorJob.perform_later(start_date, end_date, params[:asins].presence)
      flash[:notice] = 'Job is scheduled'
    else
      flash[:error] = 'Please provide start_date & end_date'
    end
    redirect_to :dashboard_index
  end
end
