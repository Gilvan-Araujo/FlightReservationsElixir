defmodule FlightexTest do
  use ExUnit.Case

  import Flightex.Factory

  alias Flightex.Bookings.Agent, as: BookingsAgent
  alias Flightex.Users.Agent, as: UsersAgent
  alias Flightex.Users.User

  describe "generate_report/2" do
    BookingsAgent.start_link(%{})
    UsersAgent.start_link(%{})

    build(:users)
    |> UsersAgent.save()

    build(:booking, complete_date: ~N[1990-05-07 01:46:20])
    |> BookingsAgent.save()

    build(:booking)
    |> BookingsAgent.save()

    expected_response = "12345678900, Brasilia, Bananeiras, 2001-05-07 03:05:00"

    Flightex.generate_report(~N[2000-01-01 23:00:07], ~N[2010-01-01 23:00:07])

    response = File.read!("report.csv")

    assert response == expected_response
  end
end

#  Flightex.Bookings.Agent.start_link(%{})
#  Flightex.Users.Agent.start_link(%{})
# {_ok, user} = Flightex.Users.User.build("J", "a@a.com", "123")
# Flightex.Users.Agent.save(user)

# {:ok, response} =
#          Booking.build(
#            ~N[1990-05-07 01:46:20],
#            "Brasilia",
#            "ilha das bananas",
#            "12345678900"
#          )
# BookingAgent.save(response)

# Flightex.build_booking_list(~N[2000-01-01 23:00:07], ~N[2010-01-01 23:00:07])
