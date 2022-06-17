import requests # Impordib requests mooduli

def download_files(url): # Defineerib funktsiooni
    local_filename = url.split('/')[-1] # Defineerib local_filename
    with requests.get(url, stream=True) as r: # Defineerib r, mis on requests.get funktsiooni parameeter
        print("Downloading...") # Printib "Downloading..."
        with open("C:/Users/Johan Godinho/Desktop/"+local_filename, 'wb') as f: # Defineerib f, mis on local_filename
            print("Writing data to file") # Printib "Writing data to file"
            for chunk in r.iter_content(chunk_size=8192): # Defineerib chunk, mis on r.iter_content funktsiooni parameeter
                f.write(chunk) # Defineerib f.write funktsiooni parameeter
    f.close() # Sulgeb faili
    print("Download complete") # Printib "Download complete"
    print("File saved as "+ local_filename) # Printib "File saved as "+ local_filename

while 1: # Korduv while loop
    print("Welcome to the image downloader") # Printib "Welcome to the image downloader"
    image_url = input(str("Image url : ")) # Küsi kasutaja sisestamist
    download_files(image_url) # Käivitab funktsiooni
    print("") # Printib ""