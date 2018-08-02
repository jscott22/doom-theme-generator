# -*- coding: utf-8 -*-

import sys
import json
import jinja2
from chroma import Color

COLORS_256_LIST = []


def lighter(color, amt):
    return Color(
        (color.hls[0], amt + (1.0 - amt) * color.hls[1], color.hls[2]), 'HLS')


def darker(color, amt):
    return Color((color.hls[0], color.hls[1] * (1.0 - amt), color.hls[2]),
                 'HLS')


def blend_colors(color1, color2):
    return Color(((color1.rgb[0] + color2.rgb[0]) / 2,
                  (color1.rgb[1] + color2.rgb[1]) / 2,
                  (color1.rgb[2] + color2.rgb[2]) / 2), 'RGB')


def round_to_256_colors(base_color):
    lowest = 3 * (256**2)
    for color in COLORS_256_LIST:
        c = Color(color["hexString"])
        distance = (c.rgb[0] - base_color.rgb[0])**2 + (
            c.rgb[1] - base_color.rgb[1])**2 + (
                c.rgb[2] - base_color.rgb[2])**2
        if distance < lowest:
            lowest = distance
            nearest_color = c
    return nearest_color


def extract_json(json_file_name):
    with open(json_file_name) as json_file:
        data = json.load(json_file)
    return data


def terminal_sexy_to_template(colors):
    # default colors
    yellow = Color(colors["color"][11])
    red = Color(colors["color"][1])
    orange = blend_colors(yellow, red)
    if Color(colors["foreground"]).hls[1] > 0.5:
        bases_function = darker
        bg_fg_function = lighter
    else:
        bases_function = lighter
        bg_fg_function = darker
    new_colors = {
        "bg": Color(colors["background"]),
        "bg-alt": bg_fg_function(Color(colors["background"]), 0.1),
        "fg": Color(colors["foreground"]),
        "fg-alt": bg_fg_function(Color(colors["foreground"]), 0.2),
        "base8": bases_function(Color(colors["foreground"]), 0.1),
        "base7": bases_function(Color(colors["foreground"]), 0.2),
        "base6": bases_function(Color(colors["foreground"]), 0.3),
        "base5": bases_function(Color(colors["foreground"]), 0.4),
        "base4": bases_function(Color(colors["foreground"]), 0.5),
        "base3": bases_function(Color(colors["foreground"]), 0.6),
        "base2": bases_function(Color(colors["foreground"]), 0.7),
        "base1": bases_function(Color(colors["foreground"]), 0.8),
        "base0": bases_function(Color(colors["foreground"]), 0.9),
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
    if new_colors["teal"] == new_colors["green"]:
        new_colors["green"] = darker(new_colors["teal"], 0.2)
    if new_colors["violet"] == new_colors["magenta"]:
        new_colors["magenta"] = darker(new_colors["violet"], 0.2)

    # 256 colors
    new_colors_256 = {}
    for color_name, color in new_colors.iteritems():
        new_colors_256[color_name + "256"] = round_to_256_colors(color)
    new_colors.update(new_colors_256)
    return new_colors


def make_file(file_name, theme):
    template_loader = jinja2.FileSystemLoader(searchpath="./")
    template_env = jinja2.Environment(loader=template_loader)
    template = template_env.get_template("doom-theme-template.el")
    with open(file_name, "w") as output_file:
        output_file.write(template.render(theme=theme))


def main(argv):
    global COLORS_256_LIST
    theme = {}
    output_file = "doom-" + argv[2] + "-theme.el"
    colors = extract_json(argv[1])
    COLORS_256_LIST = extract_json("256colors.json")
    colors = terminal_sexy_to_template(colors)
    theme["name"] = argv[2]
    theme["colors"] = colors
    make_file(output_file, theme)


if __name__ == "__main__":
    main(sys.argv)
