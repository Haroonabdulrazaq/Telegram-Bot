require 'dotenv'

Dotenv.load

module Message
WELCOME_MESSAGE=''.freeze
INFO_MESSAGE=''.freeze
BYE_MESSAGE = 'Thanks for interacting with me, hope to see you soon!'
WARNING_MESSAGE = 'Oopps!!, It seems you have entered an invaild command, you should input /commands to see the valid commands for this bot'.freeze
VALID_COMMANDS = 'Enter any of the following commands and I will reply you as soon as possible
I will reply you with the response specified next to every message:
1. Input : /start    =>  response : Starts the bot
2. Input : /commands    =>  response : List of all commands
3. Input : usd-eur(example)     =>  response : with the usd/eur exchange rate, you can use any currency of your choice
4. Input : /formular  =>  response : The calculation involve in the exchange rate
5. Input : /stop   =>  response : Send a Good bye message to user
'.freeze
end