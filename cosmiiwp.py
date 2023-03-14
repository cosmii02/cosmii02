import os
import sys
import time
import subprocess
from threading import Thread
from urwid import (MainLoop, ExitMainLoop, Text, Edit, Filler, Pile, Columns, AttrWrap, SolidFill, Overlay, WidgetWrap,
                   connect_signal, Button)

class AnimatedLoadingIcon(WidgetWrap):
    def __init__(self):
        self._icon = Text("", align="right")
        super(AnimatedLoadingIcon, self).__init__(self._icon)
        self._symbols = ["◐", "◓", "◑", "◒"]
        self._colors = ["light red", "light green", "light blue", "light magenta"]
        self._current_frame = 0
        self._main_loop = None

    def start_animation(self, main_loop):
        self._main_loop = main_loop
        self._main_loop.set_alarm_in(0, self._update)

    def _update(self, _, __):
        self._icon.set_text((self._colors[self._current_frame], self._symbols[self._current_frame]))
        self._current_frame = (self._current_frame + 1) % len(self._symbols)
        self._main_loop.set_alarm_in(0.2, self._update)

def execute_commands(commands, loading_icon=None):
    for command in commands:
        if loading_icon:
            loading_icon.start_animation(main_loop)
        subprocess.run(command, shell=True)
        if loading_icon:
            loading_icon.stop_animation(main_loop)

def on_submit(button, userdata):
    domain_name, db_name, db_user, db_pass = userdata
    domain_name = domain_name.get_edit_text()
    db_name = db_name.get_edit_text()
    db_user = db_user.get_edit_text()
    db_pass = db_pass.get_edit_text()

    # Update packages and install necessary dependencies
    commands = [
        "sudo apt update",
        "sudo apt install -y nginx mariadb-server php8.1-fpm php8.1-mysql",
        f"sudo mysql -e \"CREATE DATABASE {db_name};\"",
        f"sudo mysql -e \"CREATE USER '{db_user}'@'localhost' IDENTIFIED BY '{db_pass}';\"",
        f"sudo mysql -e \"GRANT ALL PRIVILEGES ON {db_name}.* TO '{db_user}'@'localhost';\"",
        f"sudo mysql -e \"FLUSH PRIVILEGES;\"",
        "wget https://wordpress.org/latest.tar.gz",
        "tar xzf latest.tar.gz",
        "sudo cp -R wordpress/* /var/www/html/",
        f"sudo bash -c \"cat > /etc/nginx/sites-available/wordpress <<EOL\n"
        "server {\n"
        "    listen 80;\n"
        "    root /var/www/html;\n"
        "    index index.php index.html index.htm;\n"
        f"    server_name {domain_name};\n"
        "    location / {\n"
        "        try_files $uri $uri/ /index.php?$args;\n"
        "    }\n"
        "    location ~ \.php$ {\n"
        "        include snippets/fastcgi-php.conf;\n"
        "        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;\n"
        "    }\n"
        "    location ~ /\.ht {\n"
        "        deny all;\n"
        "    }\n"
        "}\n"
        "EOL\n\"",
        "sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/",
        "sudo systemctl restart nginx",
        "sudo chown -R www-data:www-data /var/www/html",
        "sudo chmod -R 755 /var/www/html",
        "rm latest.tar.gz",
        "rm -rf wordpress",
    ]

    loading_icon = AnimatedLoadingIcon()
    loading_text = Text("Installing WordPress, please wait...")
    pile = Pile([loading_text, loading_icon])
    overlay = Overlay(pile, SolidFill(" "), align="center", valign="middle", width=("relative", 50), height=("relative", 30))
    top_widget = AttrWrap(overlay, "background")
    main_loop.widget = top_widget

    # Start executing commands in a separate thread
    thread = Thread(target=execute_commands, args=(commands, loading_icon,))
    thread.start()

def main():
    domain_name = Edit("Domain Name: ")
    db_name = Edit("Database Name: ")
    db_user = Edit("Database User: ")
    db_pass = Edit("Database Password: ", mask="*")

    submit_button = Button("Install WordPress", on_press=on_submit, user_data=(domain_name, db_name, db_user, db_pass))

    pile = Pile([
        domain_name,
        db_name,
        db_user,
        db_pass,
        submit_button,
    ])

    top_widget = AttrWrap(pile, "body")
    global main_loop
    main_loop = MainLoop(top_widget, palette=[("body", "default", "default"), ("background", "black", "black")])

    # Add the loading icon to the top right corner
    loading_icon = AnimatedLoadingIcon()
    top_widget = Overlay(loading_icon, top_widget, align='right', valign='top', width=4, height=1)

    main_loop.widget = top_widget
    main_loop.run()


if __name__ == "__main__":
    main()
