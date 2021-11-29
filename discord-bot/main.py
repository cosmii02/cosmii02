import discord
from nextcord.ext import commands


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

bot.run('OTE0ODg4NTgxOTU5NTQ4OTM4.YaTmYw.z9TjIGA7k4NqoQMPdMFiz5h8MYI')