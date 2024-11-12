class MatchChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    match = Match.find(params[:match_id])
    stream_from "match_#{match.id}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
