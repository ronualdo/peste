defmodule TelegramBotClient.Api do
  @callback post(String.t(), String.t(), map()) :: {:ok, term}

  @callback client(String.t(), String.t()) :: map()
end
