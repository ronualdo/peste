defmodule PesteApiWeb.CalendarTest do
  use ExUnit.Case, async: true

  alias PesteApiWeb.Calendar

  describe "date_now/0" do
    test "returns a date" do
      result = Calendar.date_now

      assert %Date{} = result
    end
  end
end
