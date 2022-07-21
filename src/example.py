'''
 Copyright (C) 2022  Your FullName

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; version 3.

 example-hello is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
'''

a=0
def speak(text):
    global a
    a+=1
    return text+"\n "+str(a-1)+" click : "


import pyotherside
import math

def render(image_id, requested_size):
    print('image_id: "{image_id}", size: {requested_size}'.format(**locals()))

    # width and height will be -1 if not set in QML
    if requested_size == (-1, -1):
        requested_size = (300, 300)

    width, height = requested_size

    pixels = []
    for y in range(height):
        for x in range(width):
            pixels.extend(reversed([
                255, # alpha
                int(round(255/width*x)), # red
                int(round((255-255/width*x)*(1-y/width))), # green
                int(round(255/height*y)) # blue
            ]))
    return bytearray(pixels), (width, height), pyotherside.format_argb32

pyotherside.set_image_provider(render)