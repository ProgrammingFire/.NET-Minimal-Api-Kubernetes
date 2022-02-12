var app = WebApplication.Create();

app.MapGet("/", () => $"Hello {Environment.MachineName}!");

app.Run();