defmodule Flightex do
  alias Flightex.Bookings.Agent, as: BookingAgent
  alias Flightex.Bookings.Booking

  def generate_report(from_date, to_date) do
    bookings_list = build_bookings_list(from_date, to_date)

    File.write("report.csv", bookings_list)
  end

  def build_bookings_list(from_date, to_date) do
    list =
      BookingAgent.list_all()
      |> Map.values()
      # get dates from bookings between from_date and to_date
      |> Enum.filter(fn %Booking{complete_date: date} ->
        NaiveDateTime.compare(from_date, date) == :lt and
          NaiveDateTime.compare(to_date, date) == :gt
      end)

    # build csv
    list
    |> Enum.map(fn %Booking{
                     complete_date: date,
                     local_origin: origin,
                     local_destination: destination,
                     user_id: user_id
                   } ->
      "#{user_id}, #{origin}, #{destination}, #{date}"
    end)
  end
end
