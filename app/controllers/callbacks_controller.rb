class CallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def success
    ConnectionRefreshJob.perform_later(data_params.to_hash)
    render json: { ok: true }
  end

  private

  def data_params
    params.require(:data).permit(:connection_id, :customer_id)
  end
end
