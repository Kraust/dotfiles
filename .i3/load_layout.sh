#!/bin/bash
i3-msg "workspace 2; append_layout ~/.i3/workspace-2a.json"
i3-msg "workspace 1; append_layout ~/.i3/workspace-1.json"

(alacritty &)
(chrome &)
(chrome &)
(discord &)
