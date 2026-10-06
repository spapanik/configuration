from ptpython.layout import CompletionVisualisation
from prompt_toolkit.styles import Style

__all__ = ["configure"]


def configure(repl):
    """
    Configuration method. This is called during the start-up of ptpython.

    :param repl: `PythonRepl` instance.
    """
    # Show function signature (bool).
    repl.show_signature = True

    # Show docstring (bool).
    repl.show_docstring = False

    # Show the "[Meta+Enter] Execute" message when pressing [Enter] only
    # inserts a newline instead of executing the code.
    repl.show_meta_enter_message = True

    # Show completions. (NONE, POP_UP, MULTI_COLUMN or TOOLBAR)
    repl.completion_visualisation = CompletionVisualisation.POP_UP

    # When CompletionVisualisation.POP_UP has been chosen, use this
    # scroll_offset in the completion menu.
    repl.completion_menu_scroll_offset = 0

    # Show line numbers (when the input contains multiple lines.)
    repl.show_line_numbers = False

    # Show status bar.
    repl.show_status_bar = True

    # When the sidebar is visible, also show the help text.
    repl.show_sidebar_help = True

    # Swap light/dark colors on or off
    repl.swap_light_and_dark = False

    # Highlight matching parentheses.
    repl.highlight_matching_parenthesis = True

    # Line wrapping. (Instead of horizontal scrolling.)
    repl.wrap_lines = True

    # Mouse support.
    repl.enable_mouse_support = False

    # Complete while typing. (Don't require tab before the
    # completion menu is shown.)
    repl.complete_while_typing = False

    # Fuzzy and dictionary completion.
    repl.enable_fuzzy_completion = False
    repl.enable_dictionary_completion = False

    # Vi mode.
    repl.vi_mode = False

    # Enable the modal cursor (when using Vi mode). Other options are 'Block', 'Underline',  'Beam',  'Blink under', 'Blink block', and 'Blink beam'
    repl.cursor_shape_config = "Modal (vi)"

    # Paste mode. (When True, don't insert whitespace after new line.)
    repl.paste_mode = False

    # Use the classic prompt. (Display '>>>' instead of 'In [1]'.)
    repl.prompt_style = "classic"  # 'classic' or 'ipython'

    # Don't insert a blank line after the output.
    repl.insert_blank_line_after_output = False

    # History Search.
    # When True, going back in history will filter the history on the records
    # starting with the current input. (Like readline.)
    # Note: When enable, please disable the `complete_while_typing` option.
    #       otherwise, when there is a completion available, the arrows will
    #       browse through the available completions instead of the history.
    repl.enable_history_search = True

    # Enable auto suggestions. (Pressing right arrow will complete the input,
    # based on the history.)
    repl.enable_auto_suggest = False

    # Enable open-in-editor. Pressing C-x C-e in emacs mode or 'v' in
    # Vi navigation mode will open the input in the current editor.
    repl.enable_open_in_editor = True

    # Enable system prompt. Pressing meta-! will display the system prompt.
    # Also enables Control-Z suspend.
    repl.enable_system_bindings = True

    # Ask for confirmation on exit.
    repl.confirm_exit = True

    # Enable input validation. (Don't try to execute when the input contains
    # syntax errors.)
    repl.enable_input_validation = True

    # Use this colorscheme for the code.
    # Ptpython uses Pygments for code styling, so you can choose from Pygments'
    # color schemes. See:
    # https://pygments.org/docs/styles/
    # https://pygments.org/demo/
    repl.install_code_colorscheme("catppuccin-mocha", Style.from_dict(_mocha_code_style))
    repl.use_code_colorscheme("catppuccin-mocha")
    repl.install_ui_colorscheme("catppuccin-mocha", Style.from_dict(_mocha_ui_style))
    repl.use_ui_colorscheme("catppuccin-mocha")
    # A colorscheme that looks good on dark backgrounds is 'native':
    # repl.use_code_colorscheme("native")

    # Set color depth (keep in mind that not all terminals support true color).

    # repl.color_depth = "DEPTH_1_BIT"  # Monochrome.
    # repl.color_depth = "DEPTH_4_BIT"  # ANSI colors only.
    # repl.color_depth = "DEPTH_8_BIT"  # The default, 256 colors.
    repl.color_depth = "DEPTH_24_BIT"  # True color.

    # Min/max brightness
    repl.min_brightness = 0.0  # Increase for dark terminal backgrounds.
    repl.max_brightness = 1.0  # Decrease for light terminal backgrounds.

    # Syntax.
    repl.enable_syntax_highlighting = True

    # Get into Vi navigation mode at startup
    repl.vi_start_in_navigation_mode = False

    # Preserve last used Vi input mode between main loop iterations
    repl.vi_keep_last_used_mode = False

    # Install custom colorscheme named 'my-colorscheme' and use it.
    """
    repl.install_ui_colorscheme("my-colorscheme", Style.from_dict(_custom_ui_colorscheme))
    repl.use_ui_colorscheme("my-colorscheme")
    """

    # Add custom key binding for PDB.
    """
    @repl.add_key_binding("c-b")
    def _(event):
        " Pressing Control-B will insert "pdb.set_trace()" "
        event.cli.current_buffer.insert_text("\nimport pdb; pdb.set_trace()\n")
    """

    # Typing ControlE twice should also execute the current command.
    # (Alternative for Meta-Enter.)
    """
    @repl.add_key_binding("c-e", "c-e")
    def _(event):
        event.current_buffer.validate_and_handle()
    """

    # Typing 'jj' in Vi Insert mode, should send escape. (Go back to navigation
    # mode.)
    """
    @repl.add_key_binding("j", "j", filter=ViInsertMode())
    def _(event):
        " Map 'jj' to Escape. "
        event.cli.key_processor.feed(KeyPress(Keys("escape")))
    """

    # Custom key binding for some simple autocorrection while typing.
    """
    corrections = {
        "impotr": "import",
        "pritn": "print",
    }

    @repl.add_key_binding(" ")
    def _(event):
        " When a space is pressed. Check & correct word before cursor. "
        b = event.cli.current_buffer
        w = b.document.get_word_before_cursor()

        if w is not None:
            if w in corrections:
                b.delete_before_cursor(count=len(w))
                b.insert_text(corrections[w])

        b.insert_text(" ")
    """

    # Add a custom title to the status bar. This is useful when ptpython is
    # embedded in other applications.
    """
    repl.title = "My custom prompt."
    """


# Mocha token colors follow https://github.com/catppuccin/python.
_mocha_code_style = {
    "": "#cdd6f4",
    "pygments.comment": "#9399b2",
    "pygments.comment.preproc": "#f5c2e7",
    "pygments.keyword": "#cba6f7",
    "pygments.keyword.declaration": "#cba6f7 italic",
    "pygments.keyword.pseudo": "#f5c2e7",
    "pygments.keyword.type": "#f9e2af",
    "pygments.name.attribute": "#a6e3a1",
    "pygments.name.builtin": "#f38ba8 italic",
    "pygments.name.builtin.pseudo": "#f38ba8 noitalic",
    "pygments.name.class": "#f9e2af",
    "pygments.name.exception": "#f9e2af",
    "pygments.name.function": "#89b4fa",
    "pygments.name.label": "#94e2d5 italic",
    "pygments.name.tag": "#89b4fa",
    "pygments.name.variable": "#cdd6f4 italic",
    "pygments.name.variable.class": "#f9e2af italic",
    "pygments.literal.number": "#fab387",
    "pygments.operator": "#89dceb",
    "pygments.operator.word": "#cba6f7",
    "pygments.punctuation": "#9399b2",
    "pygments.literal.string": "#a6e3a1",
    "pygments.literal.string.escape": "#f5c2e7",
    "pygments.literal.string.regex": "#f5c2e7",
    "pygments.literal.string.symbol": "#f38ba8",
    "pygments.generic.deleted": "#f38ba8",
    "pygments.generic.emph": "#cdd6f4 underline",
    "pygments.generic.heading": "#cdd6f4 bold",
    "pygments.generic.inserted": "#cdd6f4 bold",
    "pygments.generic.output": "#6c7086",
    "pygments.generic.subheading": "#cdd6f4 bold",
}

_mocha_ui_style = {
    "": "#cdd6f4",
    "prompt": "#89b4fa bold",
    "in": "#a6e3a1 bold",
    "out": "#fab387",
    "completion-menu": "bg:#313244 #cdd6f4",
    "completion-menu.completion.current": "bg:#45475a #cdd6f4",
    "completion.param": "#94e2d5 italic",
    "completion.keyword": "#cba6f7",
    "signature-toolbar": "bg:#313244 #cdd6f4",
    "signature-toolbar current-name": "#89b4fa bold",
    "docstring": "#9399b2",
    "validation-toolbar": "bg:#f38ba8 #1e1e2e",
    "status-toolbar": "bg:#181825 #a6adc8",
    "status-toolbar.title": "underline",
    "status-toolbar.inputmode": "#f9e2af",
    "status-toolbar.key": "#89b4fa",
    "status-toolbar.pythonversion": "#cdd6f4 bold",
    "sidebar": "bg:#313244 #cdd6f4",
    "sidebar.title": "#89b4fa bold",
    "sidebar.label selected": "bg:#45475a #cdd6f4",
    "sidebar.status selected": "bg:#45475a #a6e3a1 bold",
    "sidebar.key": "#89b4fa bold",
    "sidebar.helptext": "bg:#181825 #a6adc8",
    "window-border": "#6c7086",
    "window-title": "bg:#313244 #cdd6f4",
    "accept-message": "bg:#a6e3a1 #1e1e2e",
    "exit-confirmation": "bg:#f38ba8 #1e1e2e",
}

# Custom colorscheme for the UI. See `ptpython/layout.py` and
# `ptpython/style.py` for all possible tokens.
_custom_ui_colorscheme = {
    # Blue prompt.
    "prompt": "bg:#eeeeff #000000 bold",
    # Make the status toolbar red.
    "status-toolbar": "bg:#ff0000 #000000",
}
