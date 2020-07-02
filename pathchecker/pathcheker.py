#!/usr/bin/env python
# -*- coding: utf-8 -*-

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Copyright (C) 2019  Mattia Milani <github@tiamilani>

from constants import *
from PathHandler import pathHandler
import argparse
import pickle
import os

parser = argparse.ArgumentParser()
parser.add_argument('--version', action='version',
                    version='%(prog)s '+VERSION, help="Show program's version") 
parser.add_argument('-d', '--dot', dest="dotFolder", required=False, type=str,
                    action="store", help="setup the dot directory to use")
parser.add_argument('-dd', '--deletedot', dest='deletedot', action='store_true',
                    help="delete the actual dot folder pointer")
parser.add_argument('-a', '--add', dest='addPath', required=False, type=str,
                    action="store", help="add a new path to be tracked")
parser.add_argument('-al', '--alias', dest='alias', required=False, type=str,
                    action="store", help="alias that needs to be used")
parser.add_argument('-od', '--outputdir', dest='outputDir', required=False, 
                    type=str, action="store", help="Output directory in the"
                    "dot folder to use for the file")
parser.add_argument('-op', '--outputpath', dest='outputPath', required=False, 
                    type=str, action="store", help="Output path to use, it"
                    " overrides other dotfolder and outputDir")
parser.set_defaults(feature=False)
args = parser.parse_args()

def dotfolder_setup(arg):
    try:
        dotFolder = pickle.load(open(DOTFOLDER_PICKLE_FILE_NAME, "rb"))
        if arg is not None:
            raise ValueError("A dot folder has already been setted, if you\
want to change dot folder please use the dd command\
use -h to see the help menu")
    except FileNotFoundError:
        print(DOTFOLDER_PICKLE_FILE_NAME + " Not found, setting up")
        if args.dotFolder is not None:
            dotFolder = arg
            pickle.dump(dotFolder, open(DOTFOLDER_PICKLE_FILE_NAME, "wb"))
        else:
            raise ValueError("dotFolder not defined, please consider to set one")
    return dotFolder

def save_pathHandler(handler):
    pickle.dump(handler, open(PATHHANDLER_PICKLE_FILE_NAME, "wb"))


def load_pathHandler():
    try:
        handler = pickle.load(open(PATHHANDLER_PICKLE_FILE_NAME, "rb"))
    except FileNotFoundError:
        print("Path handler not found, creating one")
        handler = pathHandler()
        save_pathHandler(handler)
    return handler

if __name__ == "__main__":
    if args.deletedot:
        os.remove(DOTFOLDER_PICKLE_FILE_NAME)
        exit(0)

    dotFolder = dotfolder_setup(args.dotFolder)
    alias = args.alias
    outputDir = args.outputDir
    outputPath = args.outputPath

    handler = load_pathHandler() 
    
    if args.addPath is not None:
        handler.add_path(args.addPath, alias, outputDir, outputPath)
    #print(dotFolder, args.addPath, args.alias)
    print(handler)
    # TODO check args
    # TODO look for already created list of cheks
    # TODO import the list
    # TODO check for differences/presences
    # TODO update eventual differences/presences
    # TODO git update if possible
    save_pathHandler(handler)
