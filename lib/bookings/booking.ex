defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(date, origin, destination, user_id) do
    uuid = UUID.uuid4()

    {:ok,
     %__MODULE__{
       complete_date: date,
       local_origin: origin,
       local_destination: destination,
       user_id: user_id,
       id: uuid
     }}
  end
end
