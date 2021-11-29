import discord
from discord import guild
from discord_slash import SlashCommand, SlashContext
from discord_slash.utils.manage_commands import create_choice, create_option

slash = SlashCommand(client, sync_commands=True)
token = "OTE0ODg4NTgxOTU5NTQ4OTM4.YaTmYw.z9TjIGA7k4NqoQMPdMFiz5h8MYI"

@slash.slash(
    name="hello",
    description="Just sends a message which is below",
    guild_ids=[884726121982222409]
)
async def _hello(ctx:SlashContext):
    await ctx.send("Hello there, what's up")

client.run(token)