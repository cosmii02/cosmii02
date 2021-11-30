import discord
from discord.ext import commands
from dislash import slash_commands
from dislash.interactions import *
from dotenv import load_dotenv
from os import getenv
load_dotenv()

client = commands.Bot(command_prefix=';')
slash = slash_commands.SlashClient(client)
test_guilds = [884726121982222406, 885620566449586176]

@slash.command(
    name="hello", # Defaults to function name
    description="Says hello",
    guild_ids=test_guilds # If not specified, the command is registered globally
    # Global registration takes more than 1 hour
)
async def hello(inter):
    await inter.reply("Sup")
    
@slash.command(
    name="add", # Defaults to function name
    description="Adding in mathz",
    guild_ids=test_guilds # If not specified, the command is registered globally
    # Global registration takes more than 1 hour
)
async def add(ctx, num1:int, num2:int):
    await ctx.reply(num1+num2)

@client.command()
async def hello(ctx):
    await ctx.reply('Hello')

@client.command()
async def add(ctx, num1:int, num2:int):
    await ctx.reply(num1+num2)

@client.command()
async def minus(ctx, num1:int, num2:int):
    await ctx.reply(num1-num2)

@client.command()
async def multi(ctx, num1:int, num2:int):
    await ctx.reply(num1*num2)

@client.command()
async def div(ctx, num1:int, num2:int):
    await ctx.reply(num1/num2) 

print("Bot is running uwu")
client.run(getenv('TOKEN'))