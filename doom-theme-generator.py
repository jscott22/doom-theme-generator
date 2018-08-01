# -*- coding: utf-8 -*-

import sys
import json
import jinja2
from chroma import Color


def lighter(color, amt):
    return Color((color.hls[0], color.hls[1] * (1.0 + amt), color.hls[2]),
                 'HLS')


def darker(color, amt):
    return Color((color.hls[0], color.hls[1] * (1.0 - amt), color.hls[2]),
                 'HLS')


def extract_colorscheme(json_file_name):
    with open(json_file_name) as json_file:
        colors = json.load(json_file)
    return colors


def terminal_sexy_to_template(colors):
    yellow = Color(colors["color"][11])
    red = Color(colors["color"][1])
    orange = Color(
        ((yellow.rgb[0] + red.rgb[0]) / 2, (yellow.rgb[1] + red.rgb[1]) / 2,
         (yellow.rgb[2] + red.rgb[2]) / 2), 'RGB')
    new_colors = {
        "bg": Color(colors["background"]),
        "bg-alt": lighter(Color(colors["background"]), 0.1),
        "fg": Color(colors["foreground"]),
        "fg-alt": lighter(Color(colors["foreground"]), 0.2),
        "base8": darker(Color(colors["foreground"]), 0.1),
        "base7": darker(Color(colors["foreground"]), 0.2),
        "base6": darker(Color(colors["foreground"]), 0.3),
        "base5": darker(Color(colors["foreground"]), 0.4),
        "base4": darker(Color(colors["foreground"]), 0.5),
        "base3": darker(Color(colors["foreground"]), 0.6),
        "base2": darker(Color(colors["foreground"]), 0.7),
        "base1": darker(Color(colors["foreground"]), 0.8),
        "base0": darker(Color(colors["foreground"]), 0.9),
        "red": red,
        "orange": orange,
        "green": Color(colors["color"][2]),
        "teal": Color(colors["color"][10]),
        "yellow": yellow,
        "blue": Color(colors["color"][12]),
        "dark-blue": Color(colors["color"][4]),
        "magenta": Color(colors["color"][13]),
        "violet": Color(colors["color"][5]),
        "cyan": Color(colors["color"][14]),
        "dark-cyan": Color(colors["color"][6])
    }
    if new_colors["blue"] == new_colors["dark-blue"]:
        new_colors["dark-blue"] = darker(new_colors["blue"], 0.2)
    if new_colors["cyan"] == new_colors["dark-cyan"]:
        new_colors["dark-cyan"] = darker(new_colors["cyan"], 0.2)
    if new_colors["green"] == new_colors["teal"]:
        new_colors["teal"] = lighter(new_colors["green"], 0.2)
    return new_colors


def make_file(file_name, theme):
    template_loader = jinja2.FileSystemLoader(searchpath="./")
    template_env = jinja2.Environment(loader=template_loader)
    template = template_env.get_template("doom-theme-template.el")
    with open(file_name, "w") as output_file:
        output_file.write(template.render(theme=theme))


def main(argv):
    theme = {}
    outuput_file = "doom-" + argv[2] + "-theme.el"
    colors = extract_colorscheme(argv[1])
    colors = terminal_sexy_to_template(colors)
    theme["name"] = argv[2]
    theme["colors"] = colors
    make_file(outuput_file, theme)


if __name__ == "__main__":
    main(sys.argv)
