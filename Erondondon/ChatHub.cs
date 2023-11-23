using Microsoft.AspNetCore.SignalR;

namespace Erondondon;

public class ChatHub: Hub
{
    public async Task Send(string message, string userName)
    {
        await Clients.All.SendCoreAsync("Receive", new object?[] { message, userName });
    }
    
}