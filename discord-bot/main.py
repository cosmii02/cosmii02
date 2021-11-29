import discord
from nextcord.ext import commands
from dotenv import load_dotenv
from os import getenv
load_dotenv()

bot = commands.Bot(command_prefix=';')

@bot.command()
async def hello(ctx):
    await ctx.reply('Hello')

@bot.command()
async def add(ctx, num1:int, num2:int):
    await ctx.reply(num1+num2)

@bot.command()
async def minus(ctx, num1:int, num2:int):
    await ctx.reply(num1-num2)

@bot.command()
async def multi(ctx, num1:int, num2:int):
    await ctx.reply(num1*num2)

print("Bot is running uwu")
bot.run(getenv('TOKEN'))