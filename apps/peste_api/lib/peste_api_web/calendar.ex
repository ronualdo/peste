defmodule PesteApiWeb.Calendar do
  def date_now do
    with {:ok, date_time} <- DateTime.now("America/Recife", Tzdata.TimeZoneDatabase) do
      DateTime.to_date(date_time)
    end
  end
end
