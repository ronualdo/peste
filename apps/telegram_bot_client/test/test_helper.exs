ExUnit.start()
Application.ensure_all_started(:bypass)
Mox.defmock(TelegramBotClient.ApiMock, for: TelegramBotClient.Api)
