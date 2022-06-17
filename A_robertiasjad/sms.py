import requests as r # Impordib requests mooduli
import json as j # Impordib json mooduli

# get service_plan_id from service.env
with open('service.env', 'r') as f:
    service_plan_id = f.read()
# get access_token from token.env file
with open("token.env", "r") as f:
    access_token = f.read()
from_ = "447520651387" # Defineerib from_
to_   = "3725585851" # Defineerib to_

headers = { # Defineerib headers
    "Authorization":f"Bearer {access_token}", # Defineerib Authorization
    "Content-Type":"application/json" # Defineerib Content-Type
} # Defineerib headers

payload = { # Defineerib payload
    "from":from_, # Defineerib from
    "to":[to_], # Defineerib to
    "body":"Kaupole meeldivad friikad" # Defineerib body
} # Defineerib payload

response = r.post( # Defineerib response
    f'https://sms.api.sinch.com/xms/v1/{service_plan_id}/batches', # Defineerib URL
    headers=headers, # Defineerib headers
    data=j.dumps(payload) # Defineerib data
).json() # Defineerib response

print(response) # Printib response