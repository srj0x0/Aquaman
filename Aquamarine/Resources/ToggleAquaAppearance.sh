#!/bin/sh

#  ToggleAquaAppearance.sh
#  Aquamarine
#
#  Created by Sergey Dokukin on 6/28/19.
#  Copyright © 2019 Sergey Dokukin. All rights reserved.

defaults write ${1} NSRequiresAquaSystemAppearance -bool ${2}
