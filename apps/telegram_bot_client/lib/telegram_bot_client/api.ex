defmodule TelegramBotClient.Api do
  @callback post(String.t(), String.t(), map()) :: {:ok, term}
end
