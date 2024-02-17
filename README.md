curl https://raw.githubusercontent.com/zanqi/dotfiles/main/setup.sh > setup.sh; chmod +x setup.sh; ./setup.sh

save  
mackup backup --force && mackup uninstall --force

restore  
mackup restore --force && mackup uninstall --force

tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='12-hour format' --rainbow_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat --powerline_prompt_style='Two lines, character' --prompt_connection=Disconnected --powerline_right_prompt_frame=No --prompt_spacing=Compact --icons='Few icons' --transient=Yes