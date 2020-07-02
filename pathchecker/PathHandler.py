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
import pandas as pd

class pathHandler:
    def __init__(self):
        self._df = pd.DataFrame(columns=COLUMNS_PATH_DF)
        self._df = self._df.set_index(COLUMNS_PATH_DF[0])

    def __str__(self):
        return self._df.to_string()

    def add_path(self, path, alias, outdir, outpath):
        if alias is None:
            alias = str(self._df.shape[0] + 1)
        if alias in self._df.index:
            raise ValueError("Duplicated alias")
        if outdir is None:
            outdir = path.split('/')
            if len(outdir) >= 2:
                outdir = outdir[-2]
            else:
                outdir = outdir[-1]
        new_row = {'path':path,
                    'active':True,
                    'outputDir':outdir,
                    'outputPath':outpath}
        pd_s = pd.Series(data=new_row, name=alias)
        self._df = self._df.append(pd_s, ignore_index=False)
