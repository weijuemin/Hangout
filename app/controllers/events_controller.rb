class EventsController < ApplicationController
  def index
    @curUser = User.find(session[:id])
    @eventsThis = Event.where(state: @curUser.state).all
    @eventsOther = Event.where.not(state: @curUser.state).all
  end

  def create
    evt = Event.create(event_params)
    if not evt.valid?
      flash[:error] = evt.errors.full_messages
    end
    redirect_to :action => :index, :controller => :events
  end

  def show
    @thisEvt = Event.find(params[:evt_id])
    @attendees = @thisEvt.attendees
    @discussions = @thisEvt.discussions
  end

  def edit
    @evt = Event.find(params[:evt_id])
  end

  def update
    evt = Event.find(params[:evt_id])
    if current_user.events.find(evt.id)
      if not evt.update(event_params)
        flash[:error] = evt.errors.full_messages
        redirect_to "/events/#{evt.id}/edit"
      end
    else
      flash[:error] = ["You don't have authorization to edit this event!"]
    end
    redirect_to "/events"
  end

  def destroy
    evt = Event.find(params[:evt_id])
    if evt.user == current_user
      evt.destroy
    else
      flash[:error] = ["Can't delete an event doesn't belong to you."]
    end
    redirect_to "/events"
  end

  def unjoin
    evt = Event.find(params[:evt_id])
    u = current_user
    if u.joiningevents.find(evt.id)
      Joinedevent.find_by(user: u, event: evt).delete
    else
      flash[:error] = ["Couldn't find this event."]
    end
    redirect_to "/events"
  end

  def join
    evt = Event.find(params[:evt_id])
    u = current_user
    u.joinedevents.create(event: evt)
    redirect_to "/events"
  end

  def comment
    evt = Event.find(params[:evt_id])
    d = Discussion.create(user: current_user, event: evt, content: params[:comment])
    if not d.valid?
      flash[:error] = d.errors.full_messages
    end
    redirect_to "/events/#{evt.id}"
  end

  def delete_cmt
    cmt = Discussion.find(params[:cmt_id])
    if cmt.user = current_user
      cmt.delete
    else
      flash[:error] = ["Can't delete other people's comment."]
    end
    redirect_to "/events/#{cmt.event_id}"
  end

  private
  def event_params
    event_params = params.require(:event).permit(:name, :date, :location, :state)
    event_params[:user] = current_user
    event_params
  end
end
